#!/usr/bin/env bash
# fragments/compile.sh
# makes sure that a program compiles,
# puts the executable into a.out,
# dumps errors and such into STUDENT_REPORT

# run the makefile with default target
echo "Compiling $NAME\..."
echo -e "## Compilation Output" >> $STUDENT_REPORT
g++ *.cpp -g -Wall -o a.out 2> >(tee -a $STUDENT_REPORT >&2)

if [ $? -ne 0 ]; then
  echo -e "## Program did not compile\n$(cat $STUDENT_REPORT)" | tee -a $STUDENT_REPORT
  exit
fi

