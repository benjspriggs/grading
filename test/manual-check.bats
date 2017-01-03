#!/usr/bin/env bats

load fixtures

source ./fragments/manual-check.sh

@test "manual_check requires a report fullpath" {
  run manual_check
  requires_argument "report"
}

