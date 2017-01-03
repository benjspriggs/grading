#!/usr/bash

setup() {
  export TMP="tmp"
  export FIXTURES="fixtures"
  export FAILING_EXAMPLE_PROJ="$FIXTURES/example-student"
  export REPORT="$TMP/report.txt"
  export EXECUTABLE="$TMP/a.out"
  mkdir "$TMP" "$TMP/foo"
  touch "$TMP/emptyfile" "$TMP/emptyfile.cpp"
  source ./fragments/common.sh
}

teardown() {
  [ -d "$TMP" ] && rm -rf "$TMP"
}

# output_contains <thing the error output should contain>
output_contains() {
  [[ "$output" == *"$1"* ]] && return 0
  return 1
}

# returns if nonzero exit and output contains a string
# requires_argument <thing the error output should contain>
requires_argument() {
  if output_contains "$1" && [[ "$status" != 0 ]]; then
    return 0;
  else
    return 1;
  fi
}
