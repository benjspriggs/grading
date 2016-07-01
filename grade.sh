# grade.sh
# super-script
# Does all the magic for grading

source fragments/common.sh

usage="grade <class> <name>"
# usage block
{
  if [ -z "$1" ]; then
    die "Missing class" "$usage"
  fi
  if [ -z "$2" ]; then
    die "Missing name" "$usage"
  fi
}

class="$1"
name="$2"

source "$class"/grade.sh "$name"
