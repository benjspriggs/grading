#!/usr/bin/env python
# linter.py
# Abstract definition of a linter

import re

class Linter(object):
    line_comment = re.compile(r"^\s?//")
    # Take a file and lint it
    # return the number of lines processed in the file
    def lint(self, fn):
        raise NotImplementedError()

    # Return the number of offenses detected by this linter
    def offenses(self):
        raise NotImplementedError()

    def report(self):
        raise NotImplementedError()

    # Return if this line has a pattern and is not a line comment
    @staticmethod
    def has(pattern, line):
        return re.search(pattern, line) and not re.search(Linter.line_comment, line)

    # Return if a filename is lintable (based on its filename)
    @staticmethod
    def is_lintable(fn):
        return ".cpp" in fn or ".h" in fn
