#!/usr/bin/env python
# class.py 
# Definitions for constraints on static members of classes

from lint import *

class StaticMemberLinter(Linter):
    class_declaration = re.compile(r"^\s?class\s\w+")
    static_var = re.compile(r"\s?\w+\s+\w+(\s?)+\[\d+\];")

    def lint(self, fn):
        if Linter.is_lintable(fn):
            file_and_lines = Linter.parseable_lines(fn)
            count = len(file_and_lines)
            in_class = False
            for filenum, line in file_and_lines:
                if not in_class:
                    file_and_lines.remove((filenum, line))
                else:
                    in_class = Linter.has(class_declaration, line) is not None
            self.offense_list[str(fn)] = file_and_lines
            return count
        return 0
