#!/usr/bin/env python
# class.py 
# Definitions for constraints on static members of classes

from lint import *

class StaticMemberLinter(Linter):
    class_declaration = re.compile(r"^\s?class\s\w+")
    static_member = re.compile(r"\s?\w+\s+\w+(\s?)+\[\d+\];")

    def lint(self, fn):
        if Linter.is_lintable(fn):
            file_and_lines = Linter.parseable_lines(fn)
            count = len(file_and_lines)
            file_and_lines = self._filter_class_decl(file_and_lines)
            file_and_lines = filter(lambda (n, l): StaticMemberLinter.has(self.static_member, l), file_and_lines)
            self.offense_list[str(fn)] = file_and_lines
            return count
        return 0

    # Filters out all lines that
    # aren't in a class declaration
    @staticmethod
    def _filter_class_decl(file_and_lines):
        in_class = False
        for filenum, line in file_and_lines:
            if Linter.has(StaticMemberLinter.class_declaration, line):
                in_class = True
            elif Linter.has(r"}", line):
                in_class = False
            elif not in_class:
                file_and_lines.remove((filenum, line))
        return file_and_lines

