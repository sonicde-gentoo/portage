"""Keep SSO packaging on native CMake exports rather than fabricated metadata."""

from pathlib import Path
import re
import unittest


ROOT = Path(__file__).resolve().parents[1]


class SSOCMakePackaging(unittest.TestCase):
    def test_all_sso_ebuilds_use_native_cmake(self):
        ebuilds = sorted((ROOT / 'sonicde-frameworks/sonic-frameworks-sso').glob('*.ebuild'))
        self.assertTrue(ebuilds)
        for ebuild in ebuilds:
            with self.subTest(ebuild=ebuild):
                text = ebuild.read_text()
                self.assertRegex(text, r'(?m)^inherit cmake$')
                self.assertNotIn('qmake-utils', text)
                self.assertNotIn('eqmake6', text)
                self.assertNotIn('INSTALL_ROOT=', text)
                self.assertIn('-DBUILD_SIGNOND=ON', text)
                self.assertIn('-DCMAKE_INSTALL_SYSCONFDIR="${EPREFIX}/etc"', text)
                self.assertNotRegex(text, r'(?m)^src_install\(\)')

    def test_qt_dependencies_match_native_cmake_components(self):
        for ebuild in (ROOT / 'sonicde-frameworks/sonic-frameworks-sso').glob('*.ebuild'):
            with self.subTest(ebuild=ebuild):
                text = ebuild.read_text()
                match = re.search(r'dev-qt/qtbase:6\[([^]]+)\]', text)
                self.assertIsNotNone(match)
                self.assertTrue({'dbus', 'network', 'sql', 'xml'} <= set(match.group(1).split(',')))


if __name__ == '__main__':
    unittest.main()
