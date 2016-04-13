#!/usr/bin/env bash
# fragments/manual-check.sh
# Manually open up all .h and .cpp files
# in the current directory

# TODO add some way to process comment density?
if ls -l *.h > /dev/null 2>&1;then
  vim -p *.h $STUDENT_REPORT
fi
if ls -l *.cpp > /dev/null 2>&1; then
  vim -p *.cpp $STUDENT_REPORT
fi

