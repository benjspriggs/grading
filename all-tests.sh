#!/bin/sh
# run all tests

for _test in `find . -name "*.bats"`; do
	echo Running "'$_test'"...
	bats $_test
done
