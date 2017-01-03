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
  # assume we are in the root of the
  # project to compile

  local name="$1"
  local report="$2"
  local executable="$3"

  local source_files="$(find . -name "*.cpp" | xargs echo)"

  echo -e "Compiling $name\..."

  # Compile with all errors enabled
  compiler_output=`g++ $source_files -Wall -o "$executable" 2>&1`
  res="$?"

  if [ ! -z "$compiler_output" ]; then
    echo -e "\t\t## Compilation feedback" >> "$report"
    echo -e "$compiler_output" >> "$report"
  fi

  if [ $res -ne 0 ];then
    echo "### Program did not compile, or compiled with errors" >> "$report"
  fi

  return $res
}

