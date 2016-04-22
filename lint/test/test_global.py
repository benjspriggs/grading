#!/usr/bin/env bash
# test/test_global.py
# Test for the global variable linter

from unittest import TestCase, main
from lib import GlobalVariableLinter

class GlobalVariableLinterTest(TestCase):
    has_global = "test/fixtures/has-global.cpp"
    well_formatted = "test/fixtures/well-formatted.cpp"

    def test_lint(self):
