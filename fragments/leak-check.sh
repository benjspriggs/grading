#!/usr/bin/env bash
# fragments/leak-check.sh
# Makes sure a program has no leaks
# based on the first argument given (executable name)
# Errors are dumped into a $PWD/valgrind_output.txt,
# then appended to a student's report

leak_check() {
  local usage="leak_check <program-name> <report>"

  # usage block
  {
    if [ -z "$1" -o ! -x "$1" ]; then
      die "'$1' is not exectutable or does not exist" "$usage"
    fi

    if [ -z "$2" ]; then
      die "Missing report filename" "$usage"
    fi
  }

  local program="$1"
  local report="$2"

  local LOG_FILE="$PWD/valgrind_output.txt"
  echo "Checking for leaks..."

  valgrind --leak-check=full --error-exitcode=2 --log-file=$LOG_FILE ./"$1"

  retval=$?
  if [ $retval -ne 0 ]; then
    # if there is, add the valgrind output to the file
    echo "Valgrind encountered errors, dumping output to $LOG_FILE..."
    if [ $retval = 2 ]; then
      ERR_CODE="\t## Destructors did not deallocate all dynamic memory"
    else
      ERR_CODE="\t## Program did not complete successfully due to runtime errors"
    fi
    echo -e "$ERR_CODE\nFrom valgrind:" >> $report
    cat $LOG_FILE >> $report
  fi

  # clean up
  rm $LOG_FILE
  return $retval
}
