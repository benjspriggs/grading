#!/usr/bash

setup() {
  export TMP="tmp"
    export FIXTURES="fixtures"
    export FAILING_EXAMPLE_PROJ="$FIXTURES/example-student"
    export REPORT="$TMP/report.txt"
    export EXECUTABLE="$TMP/a.out"
    mkdir "$TMP" "$TMP/foo"
    touch "$TMP/emptyfile" "$TMP/emptyfile.cpp"
}

teardown() {
  [ -d "$TMP" ] && rm -rf "$TMP"
}

