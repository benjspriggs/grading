#!/usr/bin/env bats

load fixtures

source ./fragments/compile.sh

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
    [ "$status" == 1 ]
    [ $(expr "$output" : "executable") -eq 0 ]
}

@test "compile_strict gives output and nonzero exit status with empty folder" {
  run compile_strict "$TMP/foo" "$TMP/report.txt" "$EXECUTABLE"
    [ "$status" != 0 ]
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

