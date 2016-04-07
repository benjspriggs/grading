#!/usr/bin/env python
# loop-control.py
# Ensures provided C++ source meets loop control standards
# ex. no break, while(true), continue

import sys, getopt, re

forever_while = re.compile(r"while\s?\((-?[1-9]+|true)?\)")
class_declaration = re.compile(r"^\s?class\s\w+")
bracket = re.compile(r"\{\}")

# Return if a substring matches a compiled regex pattern
def has(pattern, string):
    return re.search(pattern, string) is not None

def offense(lineno, offense, line):
    if offense is None:
        offense = "Offense"
    print(offense + " at line " + str(lineno) + ": \"" + line + "\"")

def main(argv):
    with open("loop-control.py") as inF:
        for lineno, line in enumerate(inF.read().splitlines()):
            if has(forever_while, line):
                offense(lineno, "The line had an illegal while loop", line)
            if has(class_declaration, line):
                offense(lineno, "Class declaration", line)

if __name__ == "__main__":
    main(sys.argv[1:])
"""
class SomeClass
{
    public:
        int staticArray[23];
}
"""
