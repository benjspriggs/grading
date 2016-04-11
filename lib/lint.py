#!/usr/bin/env python
# linter.py
# Abstract definition of a linter

import re

class Linter:
    line_comment = re.compile(r"^\s?//")
    # Take a file and lint it
    # return the number of lines processed in the file
    def lint(self, fn):
        raise NotImplementedError()

    # Return the number of offenses detected by this linter
    def offenses(self):
        raise NotImplementedError()

    # Return if this line has a pattern and is not a line comment
    def has(pattern, line):
        return re.search(pattern, line) and not re.search(line_comment, line)
