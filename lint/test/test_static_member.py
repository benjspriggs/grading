#!/usr/bin/env python
# test_static_member.py
# Test for Static Member linter

from unittest import TestCase, main
from lint.lib import StaticMemberLinter

class StaticMemberLinterTest(TestCase):
    has_static = "test/fixtures/has-static.cpp"
    well_formatted = "test/fixtures/well-formatted.cpp"

    def test_lint(self):
        s = [StaticMemberLinter(), StaticMemberLinter()]
        self.assertEquals(len(StaticMemberLinter.parseable_lines(self.has_static)),
                s[0].lint(self.has_static))
        self.assertEquals(len(StaticMemberLinter.parseable_lines(self.well_formatted)),
                s[1].lint(self.well_formatted))
        self.assertNotEquals(s[0].offenses(), s[1].offenses())
        self.assertEquals(1, s[0].offenses())
