# cs202-style.py
# Stylechecks a bunch of files based on the cs202 style

import linter, sys, getopt

if __name__ == "__main__":
    for each in sys.argv[1:]:
        print("**** Linting " + each + "...")
        linter.lint(each)
