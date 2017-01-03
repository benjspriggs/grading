#!/usr/bin/env bats

load fixtures

source ./fragments/common.sh

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
