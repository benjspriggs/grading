#!/usr/bin/env python
# loop_control.py
# A class that lints a file, checking for illegal loops

from lint import *

class LoopControlLinter(Linter):
    def initialize(self):
        self.offenses = 0

    def lint(self, fn):
        return is_lintable(fn)

    def offenses(self):
        return self.offenses

