#!/usr/bin/env bash
# cs163/grade.sh
# Script to automatedly grade a student's homework
# Runs through a series of checks, and puts output to a file
# author :: Benjamin Spriggs

WORKING_DIRECTORY=$(pwd)
SCRIPT_SOURCE=$(readlink -f $0)
GRADING_HOME=${SCRIPT_SOURCE%%/cs163/grade.sh}
HELP_MSG="Usage: grade [student-dir] [--help]
This script takes a student's folder name and runs through automated grading operations for PSU CS163.
It will dump out a text file with:
  the student's name
  any compile errors
  other notes
in the current working directory ($WORKING_DIRECTORY)."

# display help message if requested
source $GRADING_HOME/fragments/help.sh

# make sure we have all the arguments
if [ -z $1 ]; then
  echo "$HELP_MSG"
  exit 1
fi

STUDENT_NAME=$1
STUDENT_REPORT=$WORKING_DIRECTORY/${STUDENT_NAME%/}.txt

## Program must compile
source $GRADING_HOME/fragments/compile.sh a.out

## Program must run without runtime faults, and not leak
source $GRADING_HOME/fragments/leak-check.sh a.out

# manually check for everything else
source $GRADING_HOME/fragments/manual-check.sh

# finish execution
echo "Anonymizing $STUDENT_REPORT..."
sed -i -e "s:$(pwd):\.\.\.:g" $STUDENT_REPORT # anonymize the file paths

echo "Finished grading ${STUDENT_NAME%/} in $(pwd), returning to grading directory..."
cd $WORKING_DIRECTORY
echo "Done."

