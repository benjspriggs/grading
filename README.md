[![Build Status](https://travis-ci.org/benjspriggs/grading.svg?branch=add-bats)](https://travis-ci.org/benjspriggs/grading)
# Grading Scripts for CS{162,163,202}
A series of scripts for ease of use in grading assignments for Karla's undergraduate Computer Science classes.
A description and usage for each script can be found below, and by running a script with the "--help" flag.

Put paths to the places the original source will be downloaded, etc in paths.sh. Makefile needs a ``compile`` and ``debug`` target, which is contained in the [one provided](makefile.example).

# Setup
The grading scripts can be run from this folder, but they require defining two paths:
 - `GRADING_LOCAL`  : Directory where copies of student's work are saved on a local machine, distro/ os doesn't matter 
   * Most helpful to be a \*nix or a machine with bash, because [the move script can help with copying from `GRADING_LOCAL` to `GRADING_REMOTE`](move.sh).
 - `GRADING_REMOTE` : Where copies of student's work are run and graded against, either a ssh alias to the PSU linux systems, or an ssh login/ url combo.
 - `MAKEFILE` : (OPTIONAL) Can be a path to a custom makefile, or the absolute path to the [example makefile provided](makefile.example). Requires a `compile` and `debug` target.
Running [`./install.sh`](install.sh) will create the requisite `paths.sh` that defines these.

# Running
Run with:
```
$ ./grade.sh <class> <student-dir>
```
Will run through a series of tests, and open each of the student's source files so the grader can look over any remaining stylistic choices, and make the final decision for the grade.
A student report will be dumped out at the end, with any notes the grader made while looking at the file.

# Moving from Local to Remote
Run with:
```
$ ./grade-move.sh <student-dir> <student-archive>
```
Moves files from the grading-local to grading-remote folders, adding a makefile in the proper place for convenience.

# Issues
Currently, the scripts all have an implicit flat structure. If the grade script doesn't work on the remote machine, try moving all of the student's files out of a nested file, or deleting the `__MACOSX/` folder (usually doesn't contain anything important or relevant to grading).
