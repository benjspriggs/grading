#!/usr/bin/env bash
# fragments/compile.sh
# makes sure that a program compiles,
# puts the executable into the first argument,
# dumps errors and such into STUDENT_REPORT

# make sure we have all the arguments
if [[ -z "$1" ]]; then
  exit 1
fi

# Compile with all errors enabled
echo "Compiling $NAME\..."
echo -e "## Compilation Output" >> $STUDENT_REPORT
g++ *.cpp -g -Wall -o $1 2> >(tee -a $STUDENT_REPORT >&2)

if [ $? -ne 0 ]; then
  echo "## Program did not compile" >> cat $STUDENT_REPORT
  exit 1
fi

