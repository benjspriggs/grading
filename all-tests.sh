#!/bin/sh
# run all bats tests in dir

for _test in `find . -name "*.bats"`; do
	echo Running "'$_test'"...
	bats "$_test"
done
