#!/usr/bin/env bash
# fragments/count-globals.sh
# Count the number of global variables in every file
# Dumps everything into the student report as a 'global report'
# take a bunch of cpp files as arguments

# make sure we have the student's report
if [[ -z "$STUDENT_REPORT" ]]; then
  STUDENT_REPORT="student_report.txt"
fi

# collect all of the cpp files to lint
# (in $@)
FILES_TO_LINT=()
for file in "$@"; do
  if [[ $file =~ \.cpp ]]; then
    file=${file%%.cpp}
    FILES_TO_LINT+=("$file")
  fi
done

# count the number of files
echo -e "\t\t## Global Context Output" >> $STUDENT_REPORT
echo -e "Counted ${FILES_TO_LINT[@]} file(s)." >> $STUDENT_REPORT

# lint the files
for file in "${FILES_TO_LINT[@]}"; do
  if [ -z $file ]; then
    echo "Cannot have empty filenames."
    break
  fi

  if [ ! -f $file ]; then
    echo "File $file does not exist!"
    break
  fi

  # count the number of global variables
  globals=$( g++ -O0 -c $file.cpp && nm $file.o | grep ' B ' | wc -l )
  if [ ! -z $globals ]; then
    # get names and such of variables
    echo -e "Found $globals in $file...
    $(g++ -O0 -c B.cpp && nm B.o | egrep ' [A-Z] ' | egrep -v ' [UTW] ')" \\
      >> $STUDENT_REPORT
  fi
done
