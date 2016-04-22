#!/usr/bin/env python
# class.py 
# Definitions for constraints on static members of classes

from lint import *

class StaticMemberLinter(Linter):
    class_declaration = re.compile(r"^\s?class\s\w+")
    static_member = re.compile(r"\s?\w+\s+\w+(\s?)+\[\d+\];")

    def lint(self, fn):
        if Linter.is_lintable(fn):
            file_and_lines = StaticMemberLinter.class_declarations(fn)
            count = len(Linter.parseable_lines(fn)) # TODO: Rethink rather useless return value
            self.offense_list[str(fn)] = filter( lambda (n, l): Linter.has(StaticMemberLinter.static_member, l), file_and_lines)
            return count
        return 0

    # Filters out all lines that
    # aren't in a class declaration
    # Returns a list of tuples, (linenum, "line")
    @staticmethod
    def class_declarations(fn):
        file_and_lines = Linter.parseable_lines(fn)
        in_class = False
        for filenum, line in file_and_lines:
            if Linter.has(StaticMemberLinter.class_declaration, line):
                in_class = True
            elif Linter.has(r"}", line):
                in_class = False
            elif not in_class:
                file_and_lines.remove((filenum, line))
        return file_and_lines

