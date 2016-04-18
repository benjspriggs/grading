#!/usr/bin/env bash
# fragments/help.sh
# Display the string in HELP_MSG if --help or -h is in the arguments

# display help message if requested
for arg in $@; do
  if [ [$arg] == ["--help"] -o [$arg] == ["-h"] ]; then
    echo "$HELP_MSG"
    exit 0
  fi
done

