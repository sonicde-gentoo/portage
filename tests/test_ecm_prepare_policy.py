"""Exercise the actual ECM preparation policy without building packages."""

import os
from pathlib import Path
import re
import subprocess
import tempfile
import unittest


ROOT = Path(__file__).resolve().parents[1]
TEST_DIRS = {'appiumtests', 'autotests', 'test', 'tests'}


class ECMPreparePolicy(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        text = (ROOT / 'eclass/ecm.eclass').read_text()
        match = re.search(r'^ecm_src_prepare\(\) \{.*?^\}', text, re.M | re.S)
        if match is None:
            raise AssertionError('Cannot find ecm_src_prepare in the actual eclass')
        cls.prepare = match.group(0)

    def cleanup_calls(self, inherited, policy, enabled):
        # Mock unrelated eclass helpers and record the requested directory
        # cleanup. The branching logic is taken directly from the real eclass.
        helpers = '''
debug-print-function() { :; }
cmake_src_prepare() { :; }
has() {
    local needle=$1 item
    shift
    for item in "$@"; do
        [[ $item == "$needle" ]] && return 0
    done
    return 1
}
in_iuse() { [[ " $IUSE " == *" $1 "* ]]; }
use() { [[ " $USE " == *" $1 "* ]]; }
cmake_comment_add_subdirectory() { printf '%s\\n' "$@"; }
_ecm_strip_handbook_translations() { :; }
'''
        env = dict(os.environ, INHERITED=inherited, ECM_TEST=policy,
                   IUSE='test' if policy != 'false' else '',
                   USE='test' if enabled else '', CATEGORY='sonicde-frameworks',
                   ECM_HANDBOOK='false', ECM_HANDBOOK_DIR='doc')
        with tempfile.TemporaryDirectory(dir='/tmp/kilo') as directory:
            result = subprocess.run(['bash', '-c', helpers + self.prepare + '\necm_src_prepare\n'],
                                    cwd=directory, env=env, capture_output=True, text=True)
        self.assertEqual(result.returncode, 0, result.stderr)
        return set(result.stdout.splitlines()) & TEST_DIRS

    def test_sonic_matches_existing_kde_unit_test_policy(self):
        cases = (('false', False, TEST_DIRS),
                 ('false', True, TEST_DIRS),
                 ('true', False, TEST_DIRS),
                 ('true', True, set()),
                 ('forceoptional', False, set()),
                 ('forceoptional', True, set()))
        for policy, enabled, expected in cases:
            for inherited in ('kde.org', 'sonic'):
                with self.subTest(inherited=inherited, policy=policy, enabled=enabled):
                    self.assertEqual(self.cleanup_calls(inherited, policy, enabled), expected)

    def test_sonic_frameworks_match_existing_manual_test_policy(self):
        cases = (('false', False, TEST_DIRS),
                 ('false', True, TEST_DIRS),
                 ('true', False, TEST_DIRS),
                 ('true', True, {'tests'}),
                 ('forceoptional', False, {'tests'}),
                 ('forceoptional', True, {'tests'}))
        for policy, enabled, expected in cases:
            for inherited in ('kde.org frameworks.kde.org', 'sonic frameworks.sonic'):
                with self.subTest(inherited=inherited, policy=policy, enabled=enabled):
                    self.assertEqual(self.cleanup_calls(inherited, policy, enabled), expected)

    def test_unrelated_eclasses_are_unchanged(self):
        self.assertEqual(self.cleanup_calls('cmake', 'false', False), set())


if __name__ == '__main__':
    unittest.main()
