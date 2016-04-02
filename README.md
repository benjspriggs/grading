# Grading Scripts for CS{162,163,202}
A series of scripts for ease of use in grading assignments for Karla's undergraduate Computer Science classes.
A description and usage for each script can be found below, and by running a script with the "--help" flag.

Put paths to the places the original source will be downloaded, etc in paths.sh. Makefile needs a compile and debug target, which is contained in the one provided.

# cs202/grade
Run with:
```
$ grade <student-dir>
```
Will run through a series of tests, and open each of the student's source files so the grader can look over any remaining stylistic choices, and make the final decision for the grade.
A student report will be dumped out at the end, with any notes the grader made while looking at the file.

# Grade-move
Run with:
```
$ grade-move <student-dir> <student-archive>
```
Moves files from the grading-local to grading-remote folders, adding a makefile in the proper place for convenience.
