# grade.sh
# super-script
# Does all the magic for grading

source fragments/common.sh

usage="$0 <class> <dirname>"
# usage block
{
  if [ -z "$1" ]; then
    die "Missing class" "$usage"
  fi
  if [ -z "$2" ]; then
    die "Missing folder name" "$usage"
  fi
}

local class="$1"
local name="$2"

local GRADING_HOME=${SCRIPT_SOURCE%/*}
local HELP_MSG="Usage: $usage
This script takes a student's folder name and runs through automated grading operations for PSU $class
It will dump out a text file with:
  the student's name
  any compile errors
  other notes
in the current working directory ($PWD)."

for arg in $@; do
  if [ [$arg] == ["--help"] -o [$arg] == ["-h"] ]; then
    echo "$HELP_MSG"
    exit 0
  fi
done

source "$class"/grade.sh "$name" "$GRADING_HOME"
