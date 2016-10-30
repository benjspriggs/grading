#!/usr/bin/env bats

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

source ./fragments/common.sh

# begin tests for common
@test "die gives missing error message" {
  run die
    [ "$status" -eq 1 ]
    [ $(expr "$output" : "Missing error*") -ne 0 ]
}

@test "die gives missing usage message" {
  run die "foo"
    [ "$status" -eq 1 ]
    [ $(expr "$output" : "Missing usage*") -ne 0 ]
}
# end tests

# TODO: Add tests for grade()

source ./fragments/count-globals.sh
# begin
@test "count_globals needs report name" {
  run count_globals
    [ "$status" -eq 1 ]
    [ $(expr "$output" : "Missing report") -ne 0 ]
}

@test "compile_and_count does need filename" {
  run compile_and_count
    [ "$status" -eq 1 ]
    [ $(expr "$output" : "Missing filename") -ne 0 ]
}

@test "compile_and_count accepts and does not count an empty file" {
  run compile_and_count "$TMP/emptyfile"
    [ "$status" -eq 0 ]
    [ -z "$output" ]
}

@test "compile_and_count takes and produces correct output" {
  run compile_and_count "$FIXTURES/has-global.cpp"
    [ "$status" -eq 0 ]
    [ ! -z "$output" ]
      [ $(expr "$output" : "2") -ne 0 ]
}

@test "count_globals produces output with empty file" {
  run count_globals "$REPORT" "$TMP/emptyfile"
    [ "$status" -eq 0 ]
    [ -z "$output" ]
}

@test "count_globals produces no output with empty file with proper extension" {
  run count_globals "$REPORT" "$TMP/emptyfile.cpp"
    [ "$status" -eq 0 ]
    [ -z "$output" ]
}

@test "count_globals correctly counts globals in a file" {
  run count_globals "$REPORT" "$FIXTURES/has-global.cpp"
    [ "$status" -eq 0 ]
    echo "$output" | grep "Counted"
      echo "$output" | grep "2"
}

@test "count_globals correctly handles globals in a directory" {
  run count_globals "$REPORT" "$FAILING_EXAMPLE_PROJ"
    [ "$status" -eq 0 ]
    echo "$output" | grep "Counted"
      echo "$output" | grep "2"
}
# end

source ./fragments/compile.sh
# begin
# TODO: Write tests for compile
@test "compile_strict needs student folder name" {
  run compile_strict
    [ "$status" -eq 1 ]
    [ $(expr "$output" : "folder") -eq 0 ]
}

@test "compile_strict needs report name" {
  run compile_strict "foo"
    [ "$status" -eq 1 ]
    [ $(expr "$output" : "report") -eq 0 ]
}

@test "compile_strict needs executable name" {
  run compile_strict "foo" "bar"
    [ "$status" -eq 1 ]
    [ $(expr "$output" : "executable") -eq 0 ]
}

@test "compile_strict gives output and zero exit status with empty folder" {
  run compile_strict "$TMP/foo" "$TMP/report.txt" "$EXECUTABLE"
    [ "$status" -eq 0 ]
    [ ! -z "$output" ]
}

@test "compile_strict gives output with failing example folder" {
  run compile_strict "$FAILING_EXAMPLE_PROJ" "$TMP/foo" "$EXECUTABLE"
    [ "$status" != 0 ]
    [ ! -z "$output" ]
}

@test "compile_strict gives proper output on passing source" {
  run compile_strict "$FIXTURES/passing-source.cpp" "$TMP/foo" "$EXECUTABLE"
    [ "$status" != 0 ]
    [ ! -z "$output" ]
}
# end

source ./fragments/leak-check.sh
# begin
@test "leak_check needs a program name" {
  run leak_check
    [ "$status" != 0 ]
    [ $(expr "$output" : "program") -eq 0 ]
}

@test "leak_check needs a report name" {
  run leak_check "$EXECUTABLE"
    [ "$status" != 0 ]
    [ $(expr "$output" : "report") -eq 0 ]
}

@test "leak_check produces output on empty file" {
  touch "$EXECUTABLE"
    chmod +x "$EXECUTABLE"
    run leak_check "$EXECUTABLE" "$REPORT"
    [ "$status" = 0 ]
    [ ! -z "$output" ]
}

@test "leak_check produces output on working program with no leaks" {
  g++ "$FIXTURES/no-leaks.cpp" -o "$EXECUTABLE"
    run leak_check "$EXECUTABLE" "$REPORT"
    [ "$status" = 0 ]
    [ ! -z "$output" ]
}

@test "leak_check produces output on working program with leaks" {
  g++ "$FIXTURES/has-leaks.cpp" -o "$EXECUTABLE"
    run leak_check "$EXECUTABLE" "$REPORT"
    [ "$status" = 2 ]
    [ ! -z "$output" ]
}
# end

# TODO: Write tests for leak-check
source ./fragments/manual-check.sh

# TODO: Write tests for manual-check

source ./fragments/no-runtime-errors.sh

# TODO: Write tests for no-runtime-errors
