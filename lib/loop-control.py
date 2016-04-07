#!/usr/bin/env python
# loop-control.py
# Ensures provided C++ source meets loop control standards
# ex. no break, while(true), continue

import sys, getopt, re

comment = re.compile(r"")
forever_while = re.compile(r"while\s?\((-?[1-9]+|true)?\)")
class_declaration = re.compile(r"^\s?class\s\w+")
static_var = re.compile(r"\s?\w+\s+\w+(\s?)+\[\d+\];")

# Return if a substring matches a compiled regex pattern
def has(pattern, string):
    return re.search(pattern, string) is not None

def offense(lineno, offense, line):
    if offense is None:
        offense = "Offense"
    print(offense + " at line " + str(lineno) + ": \"" + line + "\"")

def lint(fn):
    global_offense = 0
    with open(fn, 'r') as inF:
        in_class = False
        in_comment = False
        for lineno, line in enumerate(inF.read().splitlines()):
            if has(forever_while, line):
                offense(lineno, "Illegal while loop", line)
                global_offense += 1
            if in_class and has(static_var, line):
                offense(lineno, "Static member detected", line)
                global_offense += 1
            if has(class_declaration, line):
                in_class = True
    print("There were " + str(global_offense) + " offenses in '" + fn + "'")

def main(argv):
    lint(argv[1])

if __name__ == "__main__":
    if len(sys.argv) == 1:
        print(sys.argv[0] + " <filename> ")
        exit(1)
    main(sys.argv[1:])
"""
class SomeClass
{
    public:
        int staticArray[23];
}
"""
