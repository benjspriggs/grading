#!/usr/bin/env python
# test_loop_control.py

from unittest import TestCase, main
from lint.lib import LoopControlLinter

class LoopControlLinterTest(TestCase):
    has_while_file = "test/fixtures/has-forever-while.cpp"
    has_while_file_bad = "test/fixtures/has-forever-while-bad-format.cpp"
    well_formatted = "test/fixtures/well-formatted.cpp"

    def test_lint(self):
        l = [LoopControlLinter(), LoopControlLinter()]
        self.assertEquals(len(LoopControlLinter.parseable_lines(self.has_while_file)),
                l[0].lint(self.has_while_file))
        self.assertEquals(len(LoopControlLinter.parseable_lines(self.well_formatted)),
                l[1].lint(self.well_formatted))
        self.assertNotEquals(l[0].offenses(), l[1].offenses())
        self.assertEquals(0, l[1].offenses())

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
