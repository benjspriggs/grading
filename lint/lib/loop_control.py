#!/usr/bin/env python
# loop_control.py
# A class that lints a file, checking for illegal loops

from lint import *

class LoopControlLinter(Linter):
    forever_while = re.compile(r"while\s?\((-?[1-9]+|true)?\)")
    def lint(self, fn):
        if Linter.is_lintable(fn):
            file_and_lines = Linter.parseable_lines(fn)
            offending_lines = filter(lambda x: self.has(self.forever_while, x[1]), file_and_lines)
            self.offense_list[str(fn)] = offending_lines
            return len(file_and_lines)
        return 0

    def report(self):
        print("There were " + str(self.offenses()) + " in the files.")
        print(self.offense_list)
