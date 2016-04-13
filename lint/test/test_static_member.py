#!/usr/bin/env python
# test_static_member.py
# Test for Static Member linter

from unittest import TestCase, main
from lib import StaticMemberLinter

class StaticMemberLinterTest(TestCase):
    has_static = "test/fixtures/has-static.cpp"
    def test_lint(self):
        self.assertNotEquals(StaticMemberLinter.parseable_lines(self.has_static),
                StaticMemberLinter().lint(self.has_static))
