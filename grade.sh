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
  if [[ -z "$2" || ! -d "$2" ]]; then
    die "Missing folder name" "$usage"
  fi
}

class="$1"
name="$2"
full_name="$(readlink -e $name)"

GRADING_HOME=${SCRIPT_SOURCE%/*}
HELP_MSG="Usage: $usage
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

source "$class"/grade.sh "$full_name" "$GRADING_HOME"
