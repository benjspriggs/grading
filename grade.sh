# grade.sh
# super-script
# Does all the magic for grading

SCRIPT_NAME=$(readlink -f $0)
GRADING_HOME=${SCRIPT_NAME%/*}

source $GRADING_HOME/fragments/common.sh
source $GRADING_HOME/fragments/compile.sh
source $GRADING_HOME/fragments/count-globals.sh
source $GRADING_HOME/fragments/leak-check.sh
source $GRADING_HOME/fragments/manual-check.sh
source $GRADING_HOME/fragments/no-runtime-errors.sh

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

grade "$full_name" "$class" "$GRADING_HOME"
