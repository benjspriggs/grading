#!/usr/bin/env python
# test_loop_control.py

from unittest import TestCase, main
from lib import LoopControlLinter

class LoopControlLinterTest(TestCase):
    has_while_file = "test/fixtures/has-forever-while.cpp"
    has_while_file_bad = "test/fixtures/has-forever-while-bad-format.cpp"

    def test_lint(self):
        self.assertNotEquals(sum(1 for line in open(self.has_while_file, 'rb')),
                LoopControlLinter().lint(self.has_while_file))

    def test_offenses(self):
        l = LoopControlLinter()
        self.assertEquals(0, l.offenses())
        l.lint(self.has_while_file)
        self.assertEquals(1, l.offenses())
        another_l = LoopControlLinter()
        another_l.lint(self.has_while_file_bad)
        self.assertEquals(l.offenses(), another_l.offenses())

if __name__ == "__main__":
    main()
