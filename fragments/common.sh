# fragments/common.sh
# common functions used by most fragments or scripts
# author :: Benjamin Spriggs

die () {
  local usage="die <error> <usage>"

  if [ -z "$1" ]; then
    die "Missing error" "$usage"
    return
  fi
  if [ -z "$2" ]; then
    die "Missing usage" "$usage"
    return
  fi

  echo -e "$1\nUsage: $2" 1>&2
  exit 1
}

grade () {
  local usage="grade <student-dir> <class> <grading-directory>"

  # usage block
  {
    if [[ -z "$1" || ! -d "$1" ]]; then
      die "Missing student dirname or non-direcory given" "$usage"
      exit
    fi

    if [ -z "$2" ]; then
      die "Missing class" "$usage"
    fi

    if [[ -z "$3" || ! -d "$3" ]]; then
      die "Missing grading directory or non-direcory given" "$usage"
      exit
    fi
  }

  local class="$1"
  local name="$2"
  local grading_home="$3"
  local report="$PWD/${name%/}.txt"

  source "$GRADING_HOME/fragments/$class-code.sh"
  source "$GRADING_HOME/fragments/$class-style.sh"

  # open up all of their files in vim to check for formatting and add any additional notes
  source $GRADING_HOME/fragments/manual-check.sh

  # finish execution
  echo "Anonymizing $report..."
  sed -i -e "s:$PWD:\.\.\.:g" $report # anonymize the file paths
  sed -i -e "s:$(whoami):grader:g" $report # change identity

  echo "Finished grading $name."
}
