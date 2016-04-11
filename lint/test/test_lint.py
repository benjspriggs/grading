#!/usr/bin/env python
# lint_test.py
# Test the Lint class

import unittest
from lib import Linter

class TestLinter(unittest.TestCase):
    def test_is_lintable(self):
        self.assertTrue(Linter.is_lintable("test.cpp"))
        self.assertTrue(Linter.is_lintable("test.h"))
        self.assertFalse(Linter.is_lintable("test.x"))

    def test_has(self):
        self.assertTrue(Linter.has("something", "something"))
        self.assertFalse(Linter.has("something", "//something"))


if __name__ == '__main__':
    unittest.main()
