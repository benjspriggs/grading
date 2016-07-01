#!/usr/bin/env bash
# fragments/compile.sh
# makes sure that a program compiles,
# puts the executable into the first argument,
# dumps errors and such into STUDENT_REPORT

compile_strict() {
  if [ -z $0 ]; then
    echo "Need output executable as argument: $0 <output>" &>2 
    exit 1
  fi
  # Compile with all errors enabled
  echo "Compiling $NAME\..."
  echo -e "\t\t## Compilation Output" >> $STUDENT_REPORT
  g++ *.cpp -g -Wall -o $1 2>&1 | tee -a $STUDENT_REPORT
  if [ ${PIPESTATUS[0]} -ne 0 ]; then
    echo -e "## Program did not compile\n$(cat $STUDENT_REPORT)" | tee -a $STUDENT_REPORT
  fi
}


