#!/usr/bin/env bats

source ./fragments/common.sh

setup() {
	export TMP="tmp"
	export FIXTURES="fixtures"
	export EXAMPLE_PROJ="$TMP/example-student"
	export REPORT="$TMP/report.txt"
	mkdir "$TMP" "$TMP/foo"
	touch "$TMP/emptyfile" "$TMP/emptyfile.cpp"
}

teardown() {
	[ -d "$TMP" ] && rm -rf "$TMP"
}

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

# TODO: Add tests for grade()

source ./fragments/count-globals.sh

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

@test "compile_and_count counts an empty file" {
	run compile_and_count "$TMP/emptyfile"
	[ "$status" -eq 0 ]
	[ -z "$output" ]
}

@test "compile_and_count does not need matching pattern" {
	run compile_and_count "$FIXTURES/has-global.cpp"
	[ "$status" -eq 0 ]
	[ ! -z "$output" ]
	[ $(expr "$output" : "g++") -eq 0 ]
}

@test "compile_and_count takes and produces correct output" {
	run compile_and_count "$FIXTURES/has-global.cpp"
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
	# skip "Determine output of function first, or way to check substrings"
	run count_globals "$REPORT" "$FIXTURES/has-global.cpp"
	[ "$status" -eq 0 ]
	echo "$output" | grep 'Counted'
}
