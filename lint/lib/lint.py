#!/usr/bin/env python
# linter.py
# Abstract definition of a linter

import re

class Linter(object):
    line_comment = re.compile(r"^\s?//")

    def __init__(self):
        self.offense_list = []
    # Take a file and lint it
    # return the number of lines processed in the file
    def lint(self, fn):
        raise NotImplementedError()

    # Return the number of offenses detected by this linter
    def offenses(self):
        raise NotImplementedError()

    def report(self):
        raise NotImplementedError()

    # Return if this line has a pattern
    @staticmethod
    def has(pattern, line):
        return re.search(pattern, line) is not None

    # Return if a filename is lintable (based on its filename)
    @staticmethod
    def is_lintable(fn):
        return ".cpp" in fn or ".h" in fn

    # Return a list of tuples, (filenumber, "line")
    @staticmethod
    def number_and_line(fn):
        return [x for x in enumerate(
            [line.rstrip() for line in open(fn, 'rb').read().splitlines()])]

    # Return a list of tuples, (filenumber, "line")
    # that are all not:
    #   line comments
    #   block comments
    @staticmethod
    def parseable_lines(fn):
        no_line = filter(lambda x: not Linter.has(Linter.line_comment, x[1]),
               Linter.number_and_line(fn))
        in_comment = False
        for pair in no_line: # TODO find the proper functional way to do this
            if in_comment:
                no_line.remove(pair)
            if Linter.has(r"\/\*", pair[1]):
                in_comment = True
            if Linter.has(r"\*\/", pair[1]):
                in_comment = False
        return no_line
