#!/usr/bin/env bats

load fixtures

source ./fragments/common.sh

@test "die gives missing error message" {
  run die
  requires_argument "error"
}

@test "die gives missing usage message" {
  run die "foo"
  requires_argument "usage"
}
