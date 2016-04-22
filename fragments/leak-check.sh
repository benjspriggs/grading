#!/usr/bin/env bash
# fragments/leak-check.sh
# Makes sure a program has no leaks
# based on the first argument given (executable name)
# Errors are dumped into a $WORKING_DIRECTORY/valgrind_output.txt,
# then appended to a student's report

# make sure we have all the arguments
if [[ -z "$1" || ! -x "$1" ]]; then
  echo "$1 is not executable, terminating..."
  exit 1
fi

LOG_FILE="$WORKING_DIRECTORY/valgrind_output.txt"
echo "Checking for leaks..."
# check if the program leaks any
if valgrind --leak-check=full --error-exitcode=2 --log-file=$LOG_FILE ./$1; then
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

# clean up
rm $LOG_FILE

