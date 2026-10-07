"""Test file ownership during an explicit same-version KDE stub transition.

This uses Portage in an isolated /tmp/kilo root. It does not modify host packages.
The single-command --newrepo transition is tested separately in
``test_ecm_meta_migration.py``.
"""

import os
from pathlib import Path
import shutil
import subprocess
import tempfile
import unittest
from unittest.mock import patch

import portage
from portage.const import PORTAGE_PYM_PATH, USER_CONFIG_PATH
from portage.tests.resolver.ResolverPlayground import ResolverPlayground
from migration_fixtures import slots, transition_pair, variable, version


ROOT = Path(__file__).resolve().parents[1]
PAYLOAD = '/usr/share/sonic-stub-check/karchive-owned.txt'
INSTALL = '''S="${WORKDIR}"
src_install() {
    printf '%s\\n' "${CATEGORY}/${PF}" > "${T}/karchive-owned.txt" || die
    insinto /usr/share/sonic-stub-check
    doins "${T}/karchive-owned.txt"
}
'''
FEATURES = ('collision-protect protect-owned -userpriv -usersandbox '
            '-sandbox -ipc-sandbox -network-sandbox -binpkg-signing -gpg-keepalive')


class InstalledOwnerTransition(unittest.TestCase):
    def test_explicit_stub_staging_replaces_old_owner(self):
        original_package = 'kde-frameworks/karchive'
        sonic_package = 'sonicde-frameworks/sonic-frameworks-archive'
        source, stub = transition_pair(original_package, sonic_package)
        original = original_package + '-' + version(stub)
        sonic = sonic_package + '-' + version(source)
        source_slot, original_slot = slots(source, stub)

        prefix = Path(tempfile.mkdtemp(prefix='sonic-owner-transition-', dir='/tmp/kilo'))
        with patch.dict(os.environ, {'PKGDIR': str(prefix / 'pkgdir'),
                                     'PORTAGE_GNUPGHOME': str(prefix / 'gnupg')}):
            playground = ResolverPlayground(
                ebuilds={
                    original + '::gentoo': {'EAPI': '8', 'SLOT': original_slot,
                                            'MISC_CONTENT': INSTALL},
                    original + '::sonicde': {'EAPI': '8', 'SLOT': variable(stub.read_text(), 'SLOT'),
                                             'RDEPEND': '=' + sonic + ':' + source_slot.split('/')[0]},
                    sonic + '::sonicde': {'EAPI': '8', 'SLOT': source_slot,
                                          'MISC_CONTENT': INSTALL},
                },
                eprefix=str(prefix),
                user_config={'make.conf': ['BINPKG_FORMAT="xpak"',
                                           f'FEATURES="{FEATURES}"']},
            )
        try:
            fake_bin = prefix / 'bin'
            fake_bin.mkdir(exist_ok=True)
            true = shutil.which('true')
            self.assertIsNotNone(true)
            for name in ('chown', 'chgrp'):
                (fake_bin / name).symlink_to(true)
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
                'FEATURES': FEATURES,
            }
            command = [portage._python_interpreter, shutil.which('emerge'),
                       '--oneshot']

            def emerge(*args):
                result = subprocess.run(command + list(args), env=env,
                                        capture_output=True, text=True, timeout=180)
                self.assertEqual(result.returncode, 0, result.stdout + result.stderr)

            owner = prefix / PAYLOAD.lstrip('/')
            emerge('=' + original + '::gentoo')
            self.assertEqual(owner.read_text(), original + '\n')
            # Stage the file-free stub before installing the Sonic payload.
            # --nodeps is confined to this explicit owner-transition step.
            emerge('--nodeps', '=' + original + '::sonicde')
            self.assertFalse(owner.exists())
            emerge('=' + sonic + '::sonicde')
            self.assertEqual(owner.read_text(), sonic + '\n')
            db = prefix / 'var/db/pkg'
            self.assertEqual((db / original / 'repository').read_text().strip(), 'sonicde')
            stub_contents = (db / original / 'CONTENTS').read_text()
            self.assertFalse(any(line.startswith(('obj ', 'sym '))
                                 for line in stub_contents.splitlines()), stub_contents)
            self.assertIn(str(owner), (db / sonic / 'CONTENTS').read_text())
        finally:
            playground.cleanup()


if __name__ == '__main__':
    unittest.main()
