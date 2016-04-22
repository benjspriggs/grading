#!/usr/bin/env bash
# fragments/compile.sh
# makes sure that a program compiles,
# puts the executable into the first argument,
# dumps errors and such into STUDENT_REPORT

# make sure we have all the arguments
if [[ -z "$1" ]]; then
  echo "Need executable as argument: $(readlink -f $0) <filename>"
  exit 1
fi

# Compile with all errors enabled
echo "Compiling $NAME\..."
echo -e "\t\t## Compilation Output" >> $STUDENT_REPORT
g++ *.cpp -g -Wall -o $1 2>&1 | tee -a $STUDENT_REPORT

if [ ${PIPESTATUS[0]} -ne 0 ]; then
  echo -e "\t\t## Program did not compile" >> $STUDENT_REPORT
  exit 1
fi

