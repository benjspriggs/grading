#!/usr/bin/env bash
# cs162/grade.sh
# Script to automatedly grade a student's homework
# Runs through a series of checks, and puts output to a file
# author :: Benjamin Spriggs

WORKING_DIRECTORY=$(pwd)
HELP_MSG="Usage: grade [student-dir] [--help]
This script takes a student's folder name and runs through automated grading operations for PSU CS162
It will dump out a text file with:
  the student's name
  any compile errors
  other notes
in the current working directory ($WORKING_DIRECTORY)."

source $GRADING_HOME/fragments/help.sh

# make sure we have all the arguments
if [[ -z "$1" || ! -d "$1" ]]; then
  echo "$HELP_MSG"
  exit 1
fi

STUDENT_NAME=$1
STUDENT_REPORT=$WORKING_DIRECTORY/${STUDENT_NAME%/}.txt

if [ ! -d $STUDENT_NAME ]; then
  echo "Directory '$STUDENT_NAME' does not exist."
  echo "$HELP_MSG"
  exit 1
fi

## Program must compile
source $GRADING_HOME/fragments/compile.sh a.out
## Program must not have any run-time faults
source $GRADING_HOME/fragmets/no-runtime-errors.sh a.out
## Functions must be fewer than 30 lines of code
# TODO Add line checker

# open up all of their files in vim to check for formatting and add any additional notes
echo "Manually checking for comments, headers, whitespacing and other details in source files..."
source $GRADING_HOME/fragments/manual-check.sh

# finish execution
echo "Anonymizing $STUDENT_REPORT..."
sed -i -e "s:$(pwd):\.\.\.:g" $STUDENT_REPORT # anonymize the file paths

echo "Finished grading ${STUDENT_NAME%/} in $(pwd), returning to grading directory..."
cd $WORKING_DIRECTORY
echo "Done."

