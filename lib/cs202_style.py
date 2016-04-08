# cs202-style.py
# Stylechecks a bunch of files based on the cs202 style

import loop_control, sys, getopt

if __name__ == "__main__":
    for each in sys.argv[1:]:
        print("Linting " + each)
        loop_control.lint(each)
