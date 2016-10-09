#!/usr/bin/env bats

source ./fragments/common.sh

setup() {
	export TMP="tmp"
	mkdir "$TMP"
	cp -r lint/test/fixtures tmp
	touch tmp/emptyfile
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

@test "count_globals needs program name" {
	run count_globals
	[ "$status" -eq 1 ]
	[ $(expr "$output" : "Missing program") -ne 0 ]
}

@test "count_globals needs report name" {
	run count_globals "foo"
	[ "$status" -eq 1 ]
	[ $(expr "$output" : "Missing report") -ne 0 ]
}

@test "count_globals produces output with empty file" {
	skip "Determine output of function first, or way to check substrings"
	run count_globals "$TMP/foo" emptyfile
	[ "$status" -eq 0 ]
	[ ! -z "$output" ]
}

@test "count_globals counts globals in a file" {
	skip "Determine output of function first, or way to check substrings"
	run count_globals "$TMP/foo" tmp
	[ "$status" -eq 0 ]
	echo $output | grep 'Counted'
}
