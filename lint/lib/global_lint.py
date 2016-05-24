#!/usr/bin/env python
# lib/global.py
# Lints for global variables

from lint import *

class GlobalVariableLinter(Linter):
    has_var = re.compile(r"\b(?:(?:auto\s*|const\s*|unsigned\s*|signed\s*|register\s*|volatile\s*|static\s*|void\s*|short\s*|long\s*|char\s*|int\s*|float\s*|double\s*|_Bool\s*|complex\s*)+)(?:\s+\*?\*?\s*)([a-zA-Z_][a-zA-Z0-9_]*)\s*[\[;,=)]") # TODO: This doesn't cover typedefs

    # TODO: HOW????
    def lint(self, fn):
        if Linter.is_lintable(fn):
            file_and_lines = Linter.parseable_lines(fn)
        count = len(Linter.parseable_lines(fn))
        self.offense_list[str(fn)] = _all_variables(file_and_lines)
        return count 
    return 0

    def _all_variables(fl_list):
        return filter(lambda (n, l):
                Linter.has(GlobalVariableLinter, l),
                fl_list)

