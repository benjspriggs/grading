#!/usr/bin/python3
# code.py
# Stylechecks a bunch of files based on the linting style

import lib.linting, sys, getopt, os
from lib import linting

if __name__ == "__main__":
    for f in sys.argv[1:]:
        if os.path.isfile(f):
            print("**** Linting '%s'..." % f, file=sys.stderr)
            linting.lint(f)
