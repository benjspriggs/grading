#!/usr/bin/env python
# linter.py
# Abstract definition of a linter

class Linter:
    # Take a file and lint it
    # return the number of lines processed in the file
    def lint(self, fn):
        raise NotImplementedError()

    # Return the number of offenses detected by this linter
    def offenses(self):
        raise NotImplementedError()

