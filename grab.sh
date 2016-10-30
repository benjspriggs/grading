#!/usr/bin/env bash
# grab
# Grabs a student report from a remote and pulls it onto the local grading folder

if [ -z "$1" ]; then
  echo "Argument needed. grab <student-name>"
  exit 1
fi

SCRIPT_PATH=$(readlink -f $0)
LOCATION_PATH=${SCRIPT_PATH/grab.sh/paths.sh}

source "$LOCATION_PATH"

scp $LINUX:$GRADING_REMOTE/$1\.txt $GRADING_LOCAL
