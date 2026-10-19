"""Keep Partition Manager's KPMcore dependency aligned with its CMake minimum."""

import os
from pathlib import Path
import re
import tempfile
import unittest
from unittest.mock import patch

from portage.dep import Atom, match_from_list
from portage.tests.resolver.ResolverPlayground import (
    ResolverPlayground,
    ResolverPlaygroundTestCase,
)


ROOT = Path(__file__).resolve().parents[1]
PACKAGE = ROOT / 'sonicde-base/sonic-partition-manager'


def kpmcore_dependency(version):
    text = (PACKAGE / f'sonic-partition-manager-{version}.ebuild').read_text()
    depend = re.search(r'^DEPEND="([^"]*)"', text, re.M).group(1)
    atoms = [token for token in depend.split() if 'sys-libs/kpmcore' in token]
    if len(atoms) != 1:
        raise AssertionError(f'Expected one KPMcore build dependency: {atoms}')
    if not re.search(r'^RDEPEND="\$\{DEPEND\}', text, re.M):
        raise AssertionError('Runtime dependencies must include the same KPMcore minimum')
    return atoms[0]


class PartitionManagerDependencies(unittest.TestCase):
    def test_source_minimums_and_subslot_tracking(self):
        # 26.08.0 CMake accepts the release branch beginning with 26.07 RCs.
        for version, minimum in (('26.08.0', '26.07'), ('9999', '26.07')):
            with self.subTest(version=version):
                atom = Atom(kpmcore_dependency(version))
                self.assertEqual(str(atom), f'>=sys-libs/kpmcore-{minimum}:6=')
                self.assertEqual(atom.slot_operator, '=')
                self.assertTrue(match_from_list(atom.without_slot, ['sys-libs/kpmcore-26.08.1']))
                self.assertFalse(match_from_list(atom.without_slot, ['sys-libs/kpmcore-25.12.3']))
        atom = Atom(kpmcore_dependency('26.08.0')).without_slot
        self.assertFalse(match_from_list(atom, ['sys-libs/kpmcore-26.04.3']))
        self.assertTrue(match_from_list(atom, ['sys-libs/kpmcore-26.07.90']))

    def test_resolver_installs_or_upgrades_kpmcore_before_partition_manager(self):
        manager = 'sonicde-base/sonic-partition-manager-26.08.0'
        dependency = kpmcore_dependency('26.08.0')
        ebuilds = {
            manager: {'EAPI': '8', 'SLOT': '6', 'DEPEND': dependency, 'RDEPEND': dependency},
            'sys-libs/kpmcore-26.04.3': {'EAPI': '8', 'SLOT': '6/10'},
            'sys-libs/kpmcore-26.08.1': {'EAPI': '8', 'SLOT': '6/10'},
        }
        for installed_version in (None, '26.04.3', '26.08.1'):
            with self.subTest(installed=installed_version), tempfile.TemporaryDirectory(dir='/tmp/kilo') as prefix:
                installed = {}
                if installed_version:
                    installed[f'sys-libs/kpmcore-{installed_version}'] = {'EAPI': '8', 'SLOT': '6/10'}
                with patch.dict(os.environ, {
                    'PKGDIR': str(Path(prefix) / 'pkgdir'),
                    'PORTAGE_GNUPGHOME': str(Path(prefix) / 'gnupg'),
                }):
                    playground = ResolverPlayground(
                        ebuilds=ebuilds, installed=installed, eprefix=prefix,
                        user_config={'make.conf': [
                            'BINPKG_FORMAT="xpak"',
                            'FEATURES="-binpkg-signing -gpg-keepalive"',
                        ]},
                    )
                try:
                    expected = [manager]
                    if installed_version != '26.08.1':
                        expected.insert(0, 'sys-libs/kpmcore-26.08.1')
                    case = ResolverPlaygroundTestCase(
                        ['=' + manager], success=True, mergelist=expected,
                    )
                    playground.run_TestCase(case)
                    self.assertTrue(case.test_success, case.fail_msg)
                finally:
                    playground.cleanup()


if __name__ == '__main__':
    unittest.main()
