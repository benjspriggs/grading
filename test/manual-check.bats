#!/usr/bin/env bats

load fixtures

source ./fragments/manual-check.sh

# TODO: Write tests for manual-check
@test "manual_check requires a report fullpath" {
  run manual_check
    [ "$status" -eq 1 ]
    [ $(expr "$output" : "Missing report*") -ne 0 ]
}

