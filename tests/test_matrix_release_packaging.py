"""Regression checks for the October 2026 matrix rollout (no external CSV needed)."""

import re
import subprocess
import unittest

from portage.dep import match_from_list

from migration_fixtures import OVERLAY, releases, variable, version


NEW_PACKAGES = {
    'sonic-gamma': 'kgamma',
    'sonic-power-management': 'powerdevil',
    'sonic-print-management': 'print-manager',
    'sonic-silver-sound-theme': 'ocean-sound-theme',
    'sonic-system-settings': 'systemsettings',
    'sonic-theme-sdk': 'plasma-sdk',
}


def release(name, target='6.8.0'):
    category = 'sonicde-frameworks' if name.startswith('sonic-frameworks-') else 'sonicde-base'
    matching = [path for path in releases(f'{category}/{name}')
                if version(path).split('-r')[0] == target
                or version(path).split('-r')[0].startswith(target + '.')]
    return matching[-1] if matching else OVERLAY / category / name / f'{name}-{target}.ebuild'


class MatrixReleasePackaging(unittest.TestCase):
    def test_keyboard_is_packaged_only_at_the_working_release(self):
        paths = releases('sonicde-base/sonic-keyboard')
        self.assertEqual([version(path) for path in paths], ['6.8.1'])
        text = paths[0].read_text()
        self.assertIn('qtbase-${QTMIN}:6=', text)
        self.assertIn('qtvirtualkeyboard-${QTMIN}:6=', text)
        self.assertIn('>=sonicde-base/sonic-interface-libraries-6.8.0:6=', text)
        self.assertNotRegex(text, r'(?:dev-libs/wayland|dev-util/wayland-scanner|dev-qt/qtwayland)')
        self.assertTrue((paths[0].parent / 'Manifest').is_file())
        stub = OVERLAY / 'kde-plasma/plasma-keyboard/plasma-keyboard-6.8.1.ebuild'
        self.assertIn('LICENSE="metapackage"', stub.read_text())
        self.assertIn('~sonicde-base/sonic-keyboard-${PV}:6', stub.read_text())

    def test_keyboard_is_a_versioned_build_dependency_of_all_three_consumers(self):
        dependency = '>=sonicde-base/sonic-keyboard-6.8.1:6'
        for name in ('sonic-workspace', 'sonic-screenlocker', 'sonic-login-manager'):
            with self.subTest(package=name):
                text = release(name).read_text()
                build_dependencies = re.findall(r'^DEPEND\+?="([^\"]*)"', text, re.M)
                self.assertTrue(any(dependency in value for value in build_dependencies))
                self.assertNotIn('sonic-keyboard', variable(text, 'RDEPEND'))
                if name == 'sonic-login-manager':
                    # RDEPEND expands DEPEND earlier; append afterward so this
                    # remains a build-only dependency as requested.
                    self.assertGreater(text.index('DEPEND+=" ' + dependency), text.index('RDEPEND='))

    def test_login_patch_release_dependencies_are_declared(self):
        text = release('sonic-login-manager').read_text()
        self.assertIn('>=virtual/zlib-1.2.9:=', text)
        self.assertIn('sonic-frameworks-icon-themes-${KFMIN}:6', text)

    def test_compatibility_aliases_accept_sonic_patch_versions(self):
        for name, original, target in (
            ('sonic-dr-robotnik', 'kde-plasma/drkonqi', '6.8.0'),
            ('sonic-frameworks-icon-themes', 'kde-frameworks/kiconthemes', '6.31.0'),
            ('sonic-frameworks-windowsystem', 'kde-frameworks/kwindowsystem', '6.31.0'),
        ):
            with self.subTest(package=name):
                owner = release(name, target)
                stub = OVERLAY / original / f'{original.split("/")[-1]}-{target}.ebuild'
                text = stub.read_text().replace('${PV}', target)
                dependency = re.search(r'[=~]sonicde-[^/]+/' + re.escape(name) + r'-[^\s:\[]+', text)
                self.assertIsNotNone(dependency)
                cpv = f'{owner.parent.parent.name}/{name}-{version(owner)}'
                self.assertTrue(match_from_list(dependency.group(), [cpv]))

    def test_framework_ecm_minimum_tracks_the_framework_release(self):
        eclass = (OVERLAY / 'eclass/ecm.eclass').read_text()
        block = re.search(
            r'if \[\[ \$\{CATEGORY\} == @\(kde-frameworks\|sonicde-frameworks\).*?'
            r': "\$\{KFMIN:=6\.22\.0\}"', eclass, re.S)
        self.assertIsNotNone(block)
        for category, preset, expected in (
            ('sonicde-frameworks', '', '6.31'),
            ('kde-frameworks', '', '6.31'),
            ('sonicde-base', '', '6.22.0'),
            ('sonicde-frameworks', '6.27.0', '6.27.0'),
        ):
            with self.subTest(category=category, explicit_minimum=preset):
                script = 'ver_cut() { printf 6.31; }; unset KFMIN; '
                script += f'CATEGORY={category}; '
                if preset:
                    script += f'KFMIN={preset}; '
                script += block.group() + '\nprintf "%s" "${KFMIN}"'
                self.assertEqual(subprocess.check_output(['bash', '-c', script], text=True), expected)

    def test_new_packages_have_sources_metadata_and_file_free_aliases(self):
        for name, original in NEW_PACKAGES.items():
            with self.subTest(package=name):
                owner = release(name)
                self.assertTrue(owner.is_file())
                self.assertTrue((owner.parent / 'metadata.xml').is_file())
                self.assertTrue((owner.parent / 'Manifest').is_file())
                stub = OVERLAY / 'kde-plasma' / original / f'{original}-6.8.0.ebuild'
                self.assertIn('LICENSE="metapackage"', stub.read_text())
                self.assertIn(f'sonicde-base/{name}-${{PV}}:6', stub.read_text())
                self.assertIn(f'~kde-plasma/{original}-6.8.0:6/6-sonicde', owner.read_text())

    def test_only_one_6_7_release_is_retained_per_package(self):
        for directory in {p.parent for p in OVERLAY.glob('*/*/*.ebuild')}:
            files = list(directory.glob('*.ebuild'))
            is_sonic = directory.parent.name.startswith('sonicde-')
            is_alias = any('LICENSE="metapackage"' in p.read_text()
                           and 'sonicde-' in p.read_text() for p in files)
            if not (is_sonic or is_alias):
                continue
            old = [p for p in files if version(p).startswith('6.7.')]
            with self.subTest(package=directory):
                self.assertLessEqual(len(old), 1)
                if old:
                    self.assertTrue(version(old[0]).startswith('6.7.5'))

    def test_rdp_is_not_added_to_the_new_release(self):
        self.assertFalse(release('sonic-rdp-server').exists())
        self.assertFalse((OVERLAY / 'kde-plasma/krdp/krdp-6.8.0.ebuild').exists())
        self.assertNotIn('sonic-rdp-server', release('sonicde-meta').read_text())

    def test_metapackage_uses_the_new_sonic_providers(self):
        text = release('sonicde-meta').read_text()
        self.assertIn('FRAMEWORKS_MIN=6.31.0', text)
        for name, original in NEW_PACKAGES.items():
            with self.subTest(package=name):
                self.assertIn('sonicde-base/' + name, text)
                self.assertNotIn('kde-plasma/' + original, text)

    def test_removed_wayland_build_stack_is_not_reintroduced(self):
        for path in OVERLAY.glob('sonicde-*/*/*.ebuild'):
            if not (version(path).startswith('6.8.') or version(path).startswith('6.31.0')):
                continue
            with self.subTest(ebuild=path):
                self.assertNotRegex(path.read_text(), r'(?:dev-libs/wayland|dev-util/wayland-scanner|plasma-wayland-protocols|dev-qt/qtwayland|\[wayland)')

    def test_x11_capture_dependencies_match_the_new_backends(self):
        portal = release('xdg-desktop-portal-sonicde').read_text()
        for atom in ('dev-libs/libei', 'media-video/pipewire', 'x11-libs/libxcb',
                     'x11-libs/xcb-util-image', 'x11-libs/xcb-util-renderutil',
                     'x11-libs/xcb-util-wm', 'x11-libs/libxkbcommon[X]'):
            with self.subTest(dependency=atom):
                self.assertIn(atom, portal)
        capture = release('sonic-screenies').read_text()
        for atom in ('media-video/ffmpeg', 'media-libs/libpulse', 'media-libs/opencv-4.7'):
            self.assertIn(atom, capture)
        self.assertNotIn('sonicde-base/sonic-pipewire', capture)
        self.assertNotIn('x11-libs/libXrandr', capture)

    def test_new_direct_dependencies_and_upstreamed_patch(self):
        self.assertIn('sonic-polkit:0', release('sonic-desktop-interface', '6.8.0.1').read_text())
        self.assertIn('qtvirtualkeyboard-${QTMIN}:6', release('sonic-workspace').read_text())
        self.assertIn('sonic-frameworks-settings-${KFMIN}', release('sonic-ssh-password-prompt').read_text())
        self.assertNotIn('optional-nm.patch', release('sonic-system-stats').read_text())
        self.assertNotIn('KWIN_BUILD_GLOBALSHORTCUTS', release('sonic-win').read_text())

    def test_via_declares_the_native_hid_backend_and_new_abi(self):
        text = release('sonic-frameworks-via', '6.31.0').read_text()
        self.assertIn('SLOT="6/6.31"', text)
        self.assertIn('dev-libs/hidapi', text)
        self.assertIn('virtual/pkgconfig', text)
        self.assertNotIn('qtdeclarative', text)

    def test_pyside_declares_python_and_llvm_instead_of_ecm(self):
        text = release('sonic-pyside', '6.11.2.2').read_text()
        self.assertIn('inherit cmake llvm-r2 python-single-r1', text)
        self.assertIn('llvm-core/clang:${LLVM_SLOT}=', text)
        self.assertIn('dev-python/packaging[${PYTHON_USEDEP}]', text)
        self.assertIn('=dev-qt/qtbase-$(ver_cut 1-3)*:6=', text)


if __name__ == '__main__':
    unittest.main()
