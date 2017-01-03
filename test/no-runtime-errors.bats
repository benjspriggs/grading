#!/usr/bin/env bats

load fixtures

source ./fragments/no-runtime-errors.sh

@test "no_runtime_errors requires an executable" {
  run no_runtime_errors
  requires_argument "executable"
}

@test "no_runtime_errors requires a report fullpath" {
  run no_runtime_errors "$EXECUTABLE"
  requires_argument "report"
}

