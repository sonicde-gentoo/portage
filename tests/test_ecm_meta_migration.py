"""Exercise representative SonicDE owner migrations with real Portage.

The ebuild relationship is read from the overlay. Only the expensive source
build is replaced with a small payload in an isolated /tmp/kilo prefix.
This distinguishes upgrading an older KDE version from switching repositories
at the identical version; the latter uses emerge's standard --newrepo option.
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
from portage.dep import Atom
from portage.tests.resolver.ResolverPlayground import ResolverPlayground
from migration_fixtures import releases, slots, transition_pair, variable, version as ebuild_version


OVERLAY = Path(__file__).resolve().parents[1]
ORIGINAL = 'kde-frameworks/extra-cmake-modules'
SONIC = 'sonicde-frameworks/sonic-frameworks-cmake-modules'
META = 'app-misc/sonic-migration-meta-1'  # Synthetic orchestration, not an overlay release.


class ECMMetaMigration(unittest.TestCase):
    def test_release_discovery_follows_new_versions_and_ignores_live(self):
        # These are disposable fixture versions, not required overlay releases.
        original = 'kde-plasma/example'
        sonic = 'sonicde-base/sonic-example'
        with tempfile.TemporaryDirectory(dir='/tmp/kilo') as directory:
            root = Path(directory)
            for atom in (original, sonic):
                (root / atom).mkdir(parents=True)
            for release in ('1.9', '1.10', '9999'):
                (root / original / f'example-{release}.ebuild').write_text('SLOT="0/0-sonicde"\n')
                (root / sonic / f'sonic-example-{release}.ebuild').write_text(
                    'PDEPEND="~kde-plasma/example-${PV}:0/0-sonicde"\n')
            owner, stub = transition_pair(original, sonic, root=root)
            self.assertEqual(ebuild_version(owner), '1.10')
            self.assertEqual(ebuild_version(stub), '1.10')
            (root / original / 'example-1.11.ebuild').write_text('SLOT="0/0-sonicde"\n')
            (root / sonic / 'sonic-example-1.11.ebuild').write_text(
                'PDEPEND="~kde-plasma/example-${PV}:0/0-sonicde"\n')
            (root / sonic / 'sonic-example-1.9.ebuild').unlink()
            owner, stub = transition_pair(original, sonic, root=root)
            self.assertEqual(ebuild_version(owner), '1.11')
            self.assertEqual(ebuild_version(stub), '1.11')
            self.assertEqual(len(releases(sonic, root)), 2)

    def test_latest_provider_missing_alias_is_not_silently_skipped(self):
        original = 'kde-plasma/example'
        sonic = 'sonicde-base/sonic-example'
        with tempfile.TemporaryDirectory(dir='/tmp/kilo') as directory:
            root = Path(directory)
            (root / original).mkdir(parents=True)
            (root / sonic).mkdir(parents=True)
            (root / original / 'example-1.ebuild').write_text('SLOT="0/0-sonicde"\n')
            for release in ('1', '2'):
                (root / sonic / f'sonic-example-{release}.ebuild').write_text(
                    'PDEPEND="~kde-plasma/example-${PV}:0/0-sonicde"\n')
            with self.assertRaisesRegex(AssertionError, 'compatibility ebuild is missing'):
                transition_pair(original, sonic, root=root)

    def run_transition(self, newrepo, *, original=ORIGINAL, sonic=SONIC, oldest=False,
                       older_subslot=False,
                       payload_path='usr/share/ECM/cmake/ECMConfigVersion.cmake'):
        owner, stub = transition_pair(original, sonic, oldest=oldest)
        source_version = ebuild_version(owner)
        version = ebuild_version(stub)
        source_slot, previous_slot = slots(owner, stub)
        # Version zero is an intentionally synthetic older owner, not a
        # production ebuild that must remain present in the overlay.
        old_version = version if newrepo else '0'
        if older_subslot:
            previous_slot = previous_slot.split('/')[0] + '/0'
        owner_text = owner.read_text()
        stub_text = stub.read_text()
        self.assertNotIn('src_install()', stub_text)
        self.assertNotIn('inherit ', stub_text)
        self.assertNotIn('SRC_URI=', stub_text)
        self.assertNotRegex(stub_text, r'(?m)^IUSE=.*\bsonicde\b')
        migration_blockers = [token for value in re.findall(
            r'^RDEPEND\+?="([^"]*)"', owner_text, re.M)
             for token in value.split() if token.startswith('!') and original in token]
        migration_blockers = [token.replace('${PV}', source_version) for token in migration_blockers]
        self.assertTrue(migration_blockers)
        posts = [token.replace('${PV}', source_version)
                 for value in re.findall(r'^PDEPEND\+?="([^"]*)"', owner_text, re.M)
                 for token in value.split()]
        posts = [token for token in posts if Atom(token).cp == original]
        self.assertEqual(len(posts), 1)
        post = posts[0]
        self.assertEqual(post,
                         '~' + original + '-' + version + ':' + variable(stub_text, 'SLOT'))

        payload_path = Path(payload_path)
        self.assertFalse(payload_path.is_absolute())
        payload_install = '''S="${WORKDIR}"
src_install() {
    printf '%s\\n' "${CATEGORY}/${PF}" > "${T}/migration-payload" || die
    insinto __payload_directory__
    newins "${T}/migration-payload" __payload_name__
}
'''.replace('__payload_directory__', '/' + str(payload_path.parent)).replace(
            '__payload_name__', payload_path.name)
        ebuilds = {
            original + '-' + old_version + '::gentoo': {
                'EAPI': '8', 'SLOT': previous_slot, 'MISC_CONTENT': payload_install,
            },
            original + '-' + version + '::sonicde': {
                'EAPI': '8', 'SLOT': variable(stub_text, 'SLOT'),
                # Real USE deps are validated by pkgcheck. The synthetic
                # provider tests only file ownership and dependency order.
                'RDEPEND': re.sub(r'\[[^]]+\]', '', variable(stub_text, 'RDEPEND')).replace('${PV}', version),
            },
            sonic + '-' + source_version + '::sonicde': {
                'EAPI': '8', 'SLOT': source_slot, 'RDEPEND': ' '.join(migration_blockers),
                'PDEPEND': post.replace('${PV}', version), 'MISC_CONTENT': payload_install,
            },
            META + '::sonicde': {
                'EAPI': '8', 'SLOT': '6',
                'RDEPEND': '=' + sonic + '-' + source_version + ':' + source_slot.split('/')[0],
            },
            'app-misc/existing-consumer-1::gentoo': {
                'EAPI': '8', 'RDEPEND': original + ':' + previous_slot.split('/')[0],
            },
        }
        with tempfile.TemporaryDirectory(prefix='ecm-meta-', dir='/tmp/kilo') as directory:
            prefix = Path(directory)
            features = ('collision-protect protect-owned -userpriv -usersandbox '
                        '-sandbox -ipc-sandbox -network-sandbox -binpkg-signing -gpg-keepalive')
            with patch.dict(os.environ, {'PKGDIR': str(prefix / 'pkgdir'),
                                         'PORTAGE_GNUPGHOME': str(prefix / 'gnupg')}):
                playground = ResolverPlayground(ebuilds=ebuilds, eprefix=str(prefix),
                    user_config={'make.conf': ['BINPKG_FORMAT="xpak"', f'FEATURES="{features}"']})
            try:
                self.assertEqual(Path(playground.settings['EPREFIX']), prefix)
                fake_bin = prefix / 'bin'
                fake_bin.mkdir(exist_ok=True)
                true = shutil.which('true')
                self.assertIsNotNone(true)
                # Portage's own rootless integration tests use these shims;
                # they affect only child processes in the disposable prefix.
                for name in ('chown', 'chgrp'):
                    (fake_bin / name).symlink_to(true)
                for path in (playground.distdir, prefix / USER_CONFIG_PATH,
                             prefix / 'var/cache/edb', prefix / 'var/tmp/portage'):
                    Path(path).mkdir(parents=True, exist_ok=True)
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
                emerge_path = shutil.which('emerge')
                self.assertIsNotNone(emerge_path)

                def emerge(*args):
                    result = subprocess.run([portage._python_interpreter, emerge_path,
                                             '--oneshot', *args],
                                            env=env, capture_output=True, text=True, timeout=180)
                    self.assertEqual(result.returncode, 0, result.stdout + result.stderr)

                emerge('=' + original + '-' + old_version + '::gentoo')
                payload = prefix / payload_path
                self.assertEqual(payload.read_text(), original + '-' + old_version + '\n')
                emerge('=app-misc/existing-consumer-1::gentoo')
                self.assertEqual(payload.read_text(), original + '-' + old_version + '\n')
                self.assertFalse((prefix / 'var/db/pkg' / (sonic + '-' + source_version)).exists())
                options = ['--newrepo'] if newrepo else []
                # Exactly ONE emerge invocation performs the desktop migration.
                emerge(*options, '=' + META + '::sonicde')
                self.assertEqual(payload.read_text(), sonic + '-' + source_version + '\n')
                vdb = prefix / 'var/db/pkg'
                stub_db = vdb / (original + '-' + version)
                sonic_db = vdb / (sonic + '-' + source_version)
                self.assertEqual((stub_db / 'repository').read_text().strip(), 'sonicde')
                self.assertIn(str(payload), (sonic_db / 'CONTENTS').read_text())
                self.assertFalse(any(line.startswith(('obj ', 'sym '))
                                     for line in (stub_db / 'CONTENTS').read_text().splitlines()))
                self.assertTrue((vdb / 'app-misc/existing-consumer-1').is_dir())
                if old_version != version:
                    self.assertFalse((vdb / (original + '-' + old_version)).exists())
                # Re-running the same command must preserve the new owner.
                emerge(*options, '=' + META + '::sonicde')
                self.assertEqual(payload.read_text(), sonic + '-' + source_version + '\n')
            finally:
                playground.cleanup()

    def test_plain_emerge_meta_upgrades_older_file_owner(self):
        self.run_transition(newrepo=False)

    def test_standard_emerge_newrepo_replaces_same_version_owner(self):
        self.run_transition(newrepo=True)

    def test_karchive_plain_emerge_replaces_older_gentoo_owner(self):
        self.run_transition(newrepo=False,
                            original='kde-frameworks/karchive',
                            sonic='sonicde-frameworks/sonic-frameworks-archive',
                            older_subslot=True)

    def test_karchive_newrepo_replaces_same_version_owner(self):
        self.run_transition(newrepo=True,
                            original='kde-frameworks/karchive',
                            sonic='sonicde-frameworks/sonic-frameworks-archive')

    def test_plasma_login_manager_plain_emerge_replaces_older_owner(self):
        self.run_transition(newrepo=False,
                            original='kde-plasma/plasma-login-manager',
                            sonic='sonicde-base/sonic-login-manager',
                            oldest=True)

    def test_plasma_login_manager_newrepo_replaces_same_version_owner(self):
        self.run_transition(newrepo=True,
                            original='kde-plasma/plasma-login-manager',
                            sonic='sonicde-base/sonic-login-manager',
                            oldest=True)

    def test_current_plasma_login_manager_replaces_older_owner(self):
        self.run_transition(newrepo=False,
                            original='kde-plasma/plasma-login-manager',
                            sonic='sonicde-base/sonic-login-manager')

    def test_cli_common_older_owner_translation_handoff(self):
        self.run_transition(newrepo=False,
                            original='kde-plasma/kde-cli-tools-common',
                            sonic='sonicde-base/sonic-terminal-tools',
                            payload_path='usr/share/locale/de/LC_MESSAGES/kioclient.mo')

    def test_cli_common_newrepo_same_version_handbook_handoff(self):
        self.run_transition(newrepo=True,
                            original='kde-plasma/kde-cli-tools-common',
                            sonic='sonicde-base/sonic-terminal-tools',
                            payload_path='usr/share/help/en/kdesu/index.cache.bz2')

    def test_cli_shared_data_is_not_suppressed(self):
        owners = sorted((OVERLAY / 'sonicde-base/sonic-terminal-tools').glob('*.ebuild'))
        self.assertTrue(owners)
        for owner in owners:
            with self.subTest(ebuild=owner):
                text = owner.read_text()
                self.assertEqual(variable(text, 'ECM_HANDBOOK'), 'false')
                self.assertNotIn('ecm_punt_po_install', text)
                self.assertIn('sonicde-frameworks/sonic-frameworks-doctools',
                              variable(text, 'BDEPEND'))
                self.assertIn('sys-devel/gettext', variable(text, 'BDEPEND'))
                self.assertIn('FDL-1.2', variable(text, 'LICENSE'))


if __name__ == '__main__':
    unittest.main()
