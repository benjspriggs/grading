#!/usr/bin/env python
# loop-control.py
# Ensures provided C++ source meets loop control standards
# ex. no break, while(true), continue

import sys, getopt, re

forever_while = re.compile(r"while\s?\((-?[1-9]+|true)?\)")
class_declaration = re.compile(r"^\s?class\s\w+")
static_var = re.compile(r"\s+?\w+?\s+\w+(\s?+)\[\d+\];")

# Return if a substring matches a compiled regex pattern
def has(pattern, string):
    return re.search(pattern, string) is not None

def offense(lineno, offense, line):
    if offense is None:
        offense = "Offense"
    print(offense + " at line " + str(lineno) + ": \"" + line + "\"")

def main(argv):
    with open("loop-control.py", 'r') as inF:
        in_class = False
        for lineno, line in enumerate(inF.read().splitlines()):
            if has(forever_while, line):
                offense(lineno, "Illegal while loop", line)
            if in_class and has(static_var, line):
                offense(lineno, "Static member detected", line)
            if has(class_declaration, line):
                in_class = True

if __name__ == "__main__":
    main(sys.argv[1:])
"""
class SomeClass
{
    public:
        int staticArray[23];
}
"""
