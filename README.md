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
$ ./move.sh <student-dir> <student-archive>
```
Moves files from the grading-local to grading-remote folders, adding a makefile in the proper place for convenience.

# Grading on Local Machines
Sometimes d2l is not so good at doing its only literal job.
You can work around this by downloading all of the files to grade,
and with the resulting zip filename `to_grade.zip` and path to this repo `~/path`:
```bash
$ ~/path/d2l/sort-files.sh to_grade.zip
... # output of sort-files
$ ~/path/d2l/local-grade.sh all
... # output of local-grade
```
And now there's a folder `to_grade` with all of the extracted directores with makefiles in each. To find out which students turned in work after a certain time:
```bash
$ ~/path/d2l/late.py all/index.html 'Jan 21, 2016 7:00 PM'
```
This will give you a list of names of people that turned in work after that date, as D2l has them.
# Issues
Currently, the scripts all have an implicit flat structure. If the grade script doesn't work on the remote machine, try moving all of the student's files out of a nested file, or deleting the `__MACOSX/` folder (usually doesn't contain anything important or relevant to grading).
