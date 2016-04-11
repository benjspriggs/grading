#!/usr/bin/env python
# loop_control.py
# A class that lints a file, checking for illegal loops

from lint import *

class LoopControlLinter(Linter):
    forever_while = re.compile(r"while\s?\((-?[1-9]+|true)?\)")
    def initialize(self):
        self.offenses = 0

    def lint(self, fn):
        if is_lintable(fn):
            with open(fn, 'r') as inF:
                for line in inF.read().splitlines():
                    if has(forever_while, line):
                        self.offenses.append((lineno, line, fn))

    def offenses(self):
        return len(self.offenses)

    def report(self):
        print("There were " + str(offenses()) + " in the files.")
