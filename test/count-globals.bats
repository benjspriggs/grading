#!/usr/bin/env bats

load fixtures

source ./fragments/count-globals.sh

@test "count_globals needs report name" {
  run count_globals
  requires_argument "report"
}

@test "_nm_output does need filename" {
  run _nm_output
  requires_argument "filename"
}

@test "_nm_output accepts and does not count an empty file" {
  run _nm_output "$TMP/emptyfile"
    [ "$status" -eq 0 ]
    [ -z "$output" ]
}

@test "_nm_output takes and produces correct output" {
  run _nm_output "$FIXTURES/has-global.cpp"
    [ "$status" -eq 0 ]
    [ ! -z "$output" ]
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
    [ $(expr "$output" : "Counted 2") != 0 ]
}

@test "count_globals correctly handles globals in a directory" {
  run count_globals "$REPORT" "$FAILING_EXAMPLE_PROJ"
    [ "$status" -eq 0 ]
    echo "$output" | grep "Counted"
      echo "$output" | grep "2"
}

