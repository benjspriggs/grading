# cs202-style.py
# Stylechecks a bunch of files based on the cs202 style

import lib.linting, sys, getopt, os
from lib import linting

if __name__ == "__main__":
    for f in sys.argv[1:]:
        if os.path.isfile(f):
            print("**** Linting " + f + "...")
            linting.lint(f)
