#!/usr/bin/env python
# lib/global.py
# Lints for global variables

from lint import *

class GlobalVariableLinter(Linter):
    def lint(self, fn):
        return Linter.parseable_lines(fn)
