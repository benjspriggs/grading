#!/usr/bin/env python
# test_loop_control.py

from unittest import TestCase, main
from lib import LoopControlLinter

class LoopControlLinterTest(TestCase):
    has_while_file = "test/fixtures/has-forever-while.cpp"

    def test_lint(self):
        self.assertEquals(sum(1 for line in open(self.has_while_file, 'rb')),
                LoopControlLinter().lint(self.has_while_file))

    def test_offenses(self):
        l = LoopControlLinter()
        self.assertEquals(0, l.offenses())

if __name__ == "__main__":
    main()
