#!/usr/bin/env bash
# cs202/grade.sh
# Script to automatedly grade a student's homework
# Runs through a series of checks, and puts output to a file
# author :: Benjamin Spriggs

WORKING_DIRECTORY=$(pwd)
SCRIPT_SOURCE=$(readlink -f $0)
GRADING_HOME=${SCRIPT_SOURCE%%/cs202/grade.sh}
HELP_MSG="Usage: grade [student-dir] [--help]
This script takes a student's folder name and runs through automated grading operations for PSU CS202.
It will dump out a text file with:
  the student's name
  any valgrind errors
  other notes
in the current working directory ($WORKING_DIRECTORY)."


# display help message if requested
for arg in $@; do
  if [ [$arg] == ["--help"] -o [$arg] == ["-h"] ]; then
    echo "$HELP_MSG"
    exit 0
  fi
done

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

## Program must compile
# run the makefile with default target
echo "Compiling $NAME\..."
echo -e "## Compilation Output" >> $STUDENT_REPORT
make compile 2> >(tee $STUDENT_REPORT >&2)

if [ $? -ne 0 ]; then
  echo -e "## Program did not compile\n$(cat $STUDENT_REPORT)" | tee $STUDENT_REPORT
  exit
fi

## Destructors deallocate all dynamic memory
LOG_FILE="$WORKING_DIRECTORY/valgrind_output.txt"
echo "Checking for leaks..."
# check if the program leaks any
if valgrind --leak-check=full --error-exitcode=2 --log-file=$LOG_FILE ./a.out; then
  # if there is, add the valgrind output to the file
  echo "Valgrind encountered errors, dumping output to $LOG_FILE..."
  if [[ $? == 2 ]]; then
    ERR_CODE="## Destructors did not deallocate all dynamic memory"
  else
    ERR_CODE="## Program did not complete successfully due to runtime errors"
  fi
  echo -e "$ERR_CODE\nFrom valgrind:" > $STUDENT_REPORT
  cat $LOG_FILE >> $STUDENT_REPORT
fi

rm $LOG_FILE

# Check for style
LIB_DIR=$GRADING_HOME/lib
echo "Checking obvious style errors..."
python $LIB_DIR/cs202_style.py *.h *.cpp | tee -a $STUDENT_REPORT

echo "Manually checking for comments, headers, whitespacing and other details in source files..."
# open up all of their files in vim to check for formatting and add any additional notes
# TODO add some way to process comment density?
if ls -l *.h > /dev/null 2>&1;then
  vim -p *.h $STUDENT_REPORT
fi
if ls -l *.cpp > /dev/null 2>&1; then
  vim -p *.cpp $STUDENT_REPORT
fi

# finish execution
echo "Anonymizing $STUDENT_REPORT..."
sed -i -e "s:$(pwd):\.\.\.:g" $STUDENT_REPORT # anonymize the file paths

echo "Finished grading ${STUDENT_NAME%/} in $(pwd), returning to grading directory..."
cd $WORKING_DIRECTORY
echo "Done."

