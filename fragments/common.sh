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
  local usage="grade <class> <student-dir>"

  # usage block
  {
    if [ -z "$1" ]; then
      die "Missing class" "$usage"
    fi

    if [ -z "$2" ]; then
      die "Missing student dir" "$usage"
    fi
  }
  local class="$1"
  local folder="$2"

  local WORKING_DIRECTORY=$(pwd)
  local GRADING_HOME=${SCRIPT_SOURCE%/*}
  local HELP_MSG="Usage: $usage
  This script takes a student's folder name and runs through automated grading operations for PSU $class
  It will dump out a text file with:
    the student's name
    any compile errors
    other notes
  in the current working directory ($WORKING_DIRECTORY)."

  # usage block
  {
    if [[ -z "$1" || ! -d "$1" ]]; then
      die "Missing dirname or non-direcory given" $HELP_MSG
      exit
    fi
  }

  local STUDENT_NAME="$1"
  local STUDENT_REPORT=$WORKING_DIRECTORY/${STUDENT_NAME%/}.txt

  ## Program must compile
  source $GRADING_HOME/fragments/compile.sh
  compile_strict "$STUDENT_NAME" "$STUDENT_REPORT" a.out

  ## Program must not have any run-time faults
  source $GRADING_HOME/fragments/no-runtime-errors.sh a.out
  ## Functions must be fewer than 30 lines of code
  # TODO Add line checker

  # Check for code requirements
  LIB_DIR=$GRADING_HOME/lint
  echo "Checking obvious code errors..."
  python $LIB_DIR/cs162_code.py *.h *.cpp | tee -a $STUDENT_REPORT
  # check for globals and such
  # TODO: Find a better way to find all of the .cpp files
  source $GRADING_HOME/fragments/count-globals.sh
  count_globals $STUDENT_REPORT *.cpp

  # open up all of their files in vim to check for formatting and add any additional notes
  source $GRADING_HOME/fragments/manual-check.sh

  # finish execution
  echo "Anonymizing $STUDENT_REPORT..."
  sed -i -e "s:$(pwd):\.\.\.:g" $STUDENT_REPORT # anonymize the file paths

  echo "Finished grading ${STUDENT_NAME%/} in $(pwd), returning to grading directory..."
  cd $WORKING_DIRECTORY
  echo "Done."
}
