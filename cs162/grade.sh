#!/usr/bin/env bash
# cs162/grade
# Script to automatedly grade a student's homework
# Runs through a series of checks, and puts output to a file
# author :: Benjamin Spriggs

WORKING_DIRECTORY=$(pwd)
HELP_MSG="Usage: grade [student-dir] [--help]
This script takes a student's folder name and runs through automated grading operations for PSU CS202.
It will dump out a text file with:
  the student's name
  any compile errors
  other notes
in the current working directory ($WORKING_DIRECTORY)."

# display help message if requested
for arg in $@; do
  if [ [$arg] == ["--help"] -o [$arg] == ["-h"] ]; then
    echo "$HELP_MSG"
    exit 0
  fi
done

if [ -z $1 ]; then
  echo "$HELP_MSG"
  exit 1
fi

