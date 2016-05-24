#!/usr/bin/env bash
# cs202/grade.sh
# Script to automatedly grade a student's homework
# Runs through a series of checks, and puts output to a file
# author :: Benjamin Spriggs

WORKING_DIRECTORY=$(pwd)
SCRIPT_SOURCE=$(readlink -f $0)
GRADING_HOME=${SCRIPT_SOURCE%%/cs202/grade.sh}
LIB_DIR=$GRADING_HOME/lib
HELP_MSG="Usage: grade [student-dir] [--help]
This script takes a student's folder name and runs through automated grading operations for PSU CS202.
It will dump out a text file with:
  the student's name
  any valgrind errors
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

# get into the right directory
cd $STUDENT_NAME

into_dir_with_cpp()
{
  for file in *; do
    if [ -d $file ]; then # if it is a dir
      if [ $(ls -l *.cpp  2>/dev/null | wc -l ) -lt 1 ]; then # and it has cpp files
  echo "Going into $file..."
  cd $file # go there
  break
      fi
    fi
  done
}

count=$(ls -l *.cpp 2>/dev/null | wc -l ) # count the number of cpp files in the current dir
while [ $count -lt 1 ]; do
  # find the directory to go into
  into_dir_with_cpp
  count=$(ls -l *.cpp 2>/dev/null | wc -l)
done

# clear out the old student report, if it exists
rm $STUDENT_REPORT

## Program must compile
source $GRADING_HOME/fragments/compile.sh a.out

## Destructors deallocate all dynamic memory
source $GRADING_HOME/fragments/leak-check.sh a.out

## Check for code requirements
# Check for globals
# TODO: Find better way to find all of the .cpp files
source $GRADING_HOME/fragments/count-globals.sh *.cpp

LIB_DIR=$GRADING_HOME/lib
echo "Checking obvious code errors..."
python $LIB_DIR/cs202_code.py *.h *.cpp | tee -a $STUDENT_REPORT

# open up all of their files in vim to check for formatting and add any additional notes
source $GRADING_HOME/fragments/manual-check.sh

# finish execution
echo "Anonymizing $STUDENT_REPORT..."
sed -i -e "s:$(pwd):\.\.\.:g" $STUDENT_REPORT # anonymize the file paths

echo "Finished grading ${STUDENT_NAME%/} in $(pwd), returning to grading directory..."
cd $WORKING_DIRECTORY
echo "Done."

