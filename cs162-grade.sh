#!/usr/bin/env bash
# cs162/grade.sh
# Script to automatedly grade a student's homework
# Runs through a series of checks, and puts output to a file
# author :: Benjamin Spriggs


grade()
{
  local WORKING_DIRECTORY=$(pwd)
  local HELP_MSG="Usage: grade [student-dir]
  This script takes a student's folder name and runs through automated grading operations for PSU CS162
  It will dump out a text file with:
    the student's name
    any compile errors
    other notes
  in the current working directory ($WORKING_DIRECTORY)."

  # usage block
  {
    if [[ -z "$1" || ! -d "$1" ]]; then
      die "Missing dirname or non-direcory given" $HELP_MSG
    fi
  }

  local STUDENT_NAME="$1"
  local STUDENT_REPORT=$WORKING_DIRECTORY/${STUDENT_NAME%/}.txt

  if [ ! -d $STUDENT_NAME ]; then
    echo "Directory '$STUDENT_NAME' does not exist."
    echo "$HELP_MSG"
    exit 1
  fi

  ## Program must compile
  source $GRADING_HOME/fragments/compile.sh
  compile_strict "$STUDENT_NAME" "$STUDENT_REPORT" a.out

  ## Program must not have any run-time faults
  source $GRADING_HOME/fragments/no-runtime-errors.sh a.out
  ## Functions must be fewer than 30 lines of code
  # TODO Add line checker

  # Check for code requirements
  LIB_DIR=$GRADING_HOME/lint
  echo "Checking obvious code errors..."
  python $LIB_DIR/cs162_code.py *.h *.cpp | tee -a $STUDENT_REPORT
  # check for globals and such
  # TODO: Find a better way to find all of the .cpp files
  source $GRADING_HOME/fragments/count-globals.sh
  count_globals $STUDENT_REPORT *.cpp

  # open up all of their files in vim to check for formatting and add any additional notes
  source $GRADING_HOME/fragments/manual-check.sh

  # finish execution
  echo "Anonymizing $STUDENT_REPORT..."
  sed -i -e "s:$(pwd):\.\.\.:g" $STUDENT_REPORT # anonymize the file paths

  echo "Finished grading ${STUDENT_NAME%/} in $(pwd), returning to grading directory..."
  cd $WORKING_DIRECTORY
  echo "Done."
}
