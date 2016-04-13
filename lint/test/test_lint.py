#!/usr/bin/env python
# lint_test.py
# Test the Lint class

import unittest
from lib import Linter

class TestLinter(unittest.TestCase):
    lint = Linter()
    well_formatted = "test/fixtures/well-formatted.cpp"

    def test_is_lintable(self):
        self.assertTrue(Linter.is_lintable("test.cpp"))
        self.assertTrue(Linter.is_lintable("test.h"))
        self.assertFalse(Linter.is_lintable("test.x"))

    def test_has(self):
        self.assertTrue(Linter.has("something", "something"))
        self.assertTrue(Linter.has(".*", "//something"))
        self.assertFalse(Linter.has("asdf", "jsd"))

    def test_lint(self):
        with self.assertRaises(NotImplementedError):
            TestLinter.lint.lint("filename.cpp")
            
    def test_offenses(self):
        with self.assertRaises(NotImplementedError):
            TestLinter.lint.offenses()

    def test_report(self):
        with self.assertRaises(NotImplementedError):
            TestLinter.lint.report()

    def test_number_and_lines(self):
        self.assertNotEquals(
                len(Linter.number_and_line(self.well_formatted)), 0)

    def test_parseable_lines(self):
        self.assertEquals(
                len(Linter.parseable_lines(self.well_formatted)), 4)

if __name__ == '__main__':
    unittest.main()
