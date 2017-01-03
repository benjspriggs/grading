#!/usr/bin/env bats

load fixtures

source ./fragments/leak-check.sh

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
