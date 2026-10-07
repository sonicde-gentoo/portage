"""Check that KDE compatibility ebuilds are file-free SonicDE dependencies.

Run with: python3 -m unittest discover -s tests -v
Portage integration fixtures run only under /tmp/kilo, not in the host root.
"""

import os
from pathlib import Path
import re
import shutil
import subprocess
import tempfile
import unittest
from unittest.mock import patch

import portage
from portage.const import PORTAGE_PYM_PATH, USER_CONFIG_PATH
from portage.tests.resolver.ResolverPlayground import ResolverPlayground
from migration_fixtures import slots, transition_pair, variable, version


OVERLAY = Path(__file__).resolve().parents[1]


def runtime_dependency(ebuild):
    match = re.search(r'(?m)^RDEPEND="([^"]*)"', ebuild.read_text())
    if match is None:
        raise AssertionError(f'{ebuild} has no RDEPEND')
    return match.group(1)


class FileFreeStubs(unittest.TestCase):
    def test_all_compatibility_ebuilds_do_not_install_files(self):
        checked = 0
        for ebuild in OVERLAY.glob('*/*/*.ebuild'):
            text = ebuild.read_text()
            if ('LICENSE="metapackage"' not in text
                    or 'sonicde-' not in text
                    or ebuild.relative_to(OVERLAY).parts[0].startswith('sonicde-')):
                continue
            with self.subTest(ebuild=ebuild):
                checked += 1
                self.assertIn('sonicde-', runtime_dependency(ebuild))
                self.assertNotRegex(text, r'(?m)^(?:SRC_URI|EGIT_REPO_URI)=')
                self.assertNotRegex(text, r'(?m)^src_(?:configure|compile|install)\(\)')
                self.assertNotRegex(text, r'(?m)^inherit .*\b(?:cmake|ecm|git-r3)\b')
                self.assertNotRegex(text, r'(?m)^IUSE=.*\bsonicde\b')
        self.assertGreater(checked, 0)

    def run_clean_install(self, original, sonic):
        owner, stub = transition_pair(original, sonic)
        old_version, sonic_version = version(stub), version(owner)
        source_slot, _ = slots(owner, stub)
        self.assertIn(sonic, runtime_dependency(stub))
        # Only ownership and ordering are being tested here: configure-time
        # dependencies and USE constraints are checked by pkgcheck separately.
        fake_stub_dep = re.sub(r'\[[^]]+\]', '', runtime_dependency(stub)).replace('${PV}', old_version)
        fake_install = '''S="${WORKDIR}"
src_install() {
    printf 'sonic owner\\n' > "${T}/sonic-owner.txt" || die
    insinto /usr/share/sonic-stub-check
    doins "${T}/sonic-owner.txt"
}
'''
        scratch = Path('/tmp/kilo')
        self.assertTrue(scratch.is_dir())
        prefix = Path(tempfile.mkdtemp(prefix='sonic-clean-stub-', dir=scratch))
        features = ('collision-protect protect-owned -userpriv -usersandbox '
                    '-sandbox -ipc-sandbox -network-sandbox -binpkg-signing -gpg-keepalive')
        ebuilds = {
            original + '-' + old_version: {
                'EAPI': '8', 'SLOT': variable(stub.read_text(), 'SLOT'), 'RDEPEND': fake_stub_dep,
            },
            sonic + '-' + sonic_version: {
                'EAPI': '8', 'SLOT': source_slot, 'MISC_CONTENT': fake_install,
            },
        }
        with patch.dict(os.environ, {'PKGDIR': str(prefix / 'pkgdir'),
                                     'PORTAGE_GNUPGHOME': str(prefix / 'gnupg')}):
            playground = ResolverPlayground(ebuilds=ebuilds,
                eprefix=str(prefix), user_config={'make.conf': [
                'BINPKG_FORMAT="xpak"', f'FEATURES="{features}"',
            ]})
        try:
            self.assertEqual(Path(playground.settings['EPREFIX']), prefix)
            fake_bin = prefix / 'bin'
            fake_bin.mkdir(exist_ok=True)
            for name in ('chown', 'chgrp'):
                (fake_bin / name).symlink_to(shutil.which('true'))
            for directory in (playground.distdir, prefix / USER_CONFIG_PATH,
                              prefix / 'var/cache/edb', prefix / 'var/tmp/portage'):
                Path(directory).mkdir(parents=True, exist_ok=True)
            (prefix / 'var/cache/edb/counter').write_text('100')
            env = {
                'PORTAGE_OVERRIDE_EPREFIX': str(prefix),
                'PORTAGE_REPOSITORIES': playground.settings.repositories.config_string(),
                'PORTAGE_INST_GID': str(os.getgid()),
                'PORTAGE_INST_UID': str(os.getuid()),
                'PORTAGE_PYTHON': portage._python_interpreter,
                'PATH': str(fake_bin) + ':' + os.environ['PATH'],
                'PYTHONPATH': PORTAGE_PYM_PATH,
                'FEATURES': features,
            }
            result = subprocess.run([portage._python_interpreter, shutil.which('emerge'),
                                     '--oneshot', '=' + original + '-' + old_version],
                                     capture_output=True, text=True, env=env, timeout=180)
            self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
            payload = prefix / 'usr/share/sonic-stub-check/sonic-owner.txt'
            self.assertEqual(payload.read_text(), 'sonic owner\n')
            db = prefix / 'var/db/pkg'
            self.assertIn(str(payload), (db / (sonic + '-' + sonic_version) / 'CONTENTS').read_text())
            contents = (db / (original + '-' + old_version) / 'CONTENTS').read_text()
            self.assertFalse(any(line.startswith(('obj ', 'sym '))
                                 for line in contents.splitlines()), contents)
        finally:
            playground.cleanup()

    def test_clean_framework_stub_installs_sonic_owner(self):
        self.run_clean_install('kde-frameworks/karchive',
                               'sonicde-frameworks/sonic-frameworks-archive')

    def test_clean_plasma_stub_installs_sonic_owner(self):
        self.run_clean_install('kde-plasma/kwin-x11', 'sonicde-base/sonic-win')

if __name__ == '__main__':
    unittest.main()
