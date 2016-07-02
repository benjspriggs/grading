#!/usr/bin/env bash
# fragments/compile.sh
# makes sure that a program compiles,
# puts the executable into the first argument,
# dumps errors and such into STUDENT_REPORT

compile_strict() {
  local usage="$0 <name> <student-report> <output-executable>"

  # usage block
  {
    if [ -z "$1" ]; then
      die "Need student folder name" "$usage"
      return
    fi

    if [ -z "$2" ]; then
      die "Need student report name" "$usage"
      return
    fi

    if [ -z "$3" ]; then
      die "Need output executable name" "$usage"
      return
    fi
  }

  local name="$1"
  local report="$2"
  local output="$3"

  # Compile with all errors enabled
  echo "Compiling $name\..."
  echo -e "\t\t## Compilation Output" >> "$report"
  g++ *.cpp -g -Wall -o "$output" 2>&1 | tee -a "$report"
  if [ ${PIPESTATUS[0]} -ne 0 ]; then
    echo -e "## Program did not compile\n$(cat $report)" > "$report"
  fi
}

