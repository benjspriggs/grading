#!/usr/bin/env bash
# fragments/no-runtime-errors.sh
# makes sure a program runs without any runtime errors
# dumps errors and such into STUDENT_REPORT

no_runtime_errors() {
  # make sure we have all the arguments
  local usage="no_runtime_errors <filename> <report>"

  # usage block
  {
    if [[ -z "$1" || ! -x "$1" ]]; then
      die "Need executable name" "$usage"
    fi

    if [ -z "$2" ]; then
      die "Need report name" "$usage"
    fi
  }

  local program="$1"
  local report="$2"

  # run the program
  trap "./$program" SIGSEGV

  if [ $? -ne 0 ]; then
    echo -e "## Program ran with runtime faults\nExit Code: $?" >> "$report"
    exit 1
  fi
}
