#!/usr/bin/env bash
# fragments/no-runtime-errors.sh
# makes sure a program runs without any runtime errors
# dumps errors and such into STUDENT_REPORT

# make sure we have all the arguments
if [[ -z "$1" ]]; then
  echo "Need executable as argument: $(readlink -f $0) <filename>"
  exit 1
fi

# run the program
./$1

if [ $? -ne 0 ]; then
  echo "## Program ran with runtime faults" >> $STUDENT_REPORT
  exit 1
fi

