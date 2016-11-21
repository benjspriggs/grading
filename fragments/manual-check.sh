#!/usr/bin/env bash
# fragments/manual-check.sh
# Manually open up all .h and .cpp files
# in the current directory,
# and a copy of the STUDENT_REPORT

manual_check() {
  local usage="manual_check <report-fullpath>"

  # usage block
  {
    if [[ -z "$1" ]]; then
      die "Missing report path" "$usage"
    fi
  }

  local report="$1"
  # TODO add some way to process comment density?
  if ls -l *.h > /dev/null 2>&1;then
    vim -p *.h $report
  fi
  if ls -l *.cpp > /dev/null 2>&1; then
    vim -p *.cpp $report
  fi
}
