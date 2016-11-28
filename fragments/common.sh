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
      die "Missing student dirname or non-directory given" "$usage"
      exit
    fi

    if [ -z "$2" ]; then
      die "Missing class" "$usage"
    fi

    if [[ -z "$3" || ! -d "$3" ]]; then
      die "Missing grading directory or non-directory given" "$usage"
      exit
    fi
  }

  local name="$(basename "$1")"
  local long_name="$(readlink -f "$name")"
  local class="$2"
  local grading_home="$3"
  local report="$PWD/${name%/}.txt"

  pushd $PWD
  cd "$long_name"
  if [[ $class =~ 162 ]]; then
    code_requirements_basic
  else
    code_requirements_full
    lint_feedback=
    if [[ $class =~ 163 ]]; then
      lint_feedback="${lint_feedback}$(echo; .$grading_home/lint/cs163_code.py *.h *.cpp)"
    elif [[ $class =~ 202 ]]; then
      lint_feedback="${lint_feedback}$(echo; .$grading_home/lint/cs202_code.py *.h *.cpp)"
    fi
    [[ ! -z "$lint_feedback" ]] && echo -e "\t** Linting Feedback **${lint_feedback}" >> "$report"
  fi

  # open up all of their files in vim to check for formatting and add any additional notes
  echo "Manually checking for comments, headers, whitespacing and other details in source files..."
  manual_check "$report"

  # finish execution
  echo "Anonymizing $report..."
  sed -i -e "s:$PWD:\.\.\.:g" $report # anonymize the file paths
  sed -i -e "s:$(whoami):grader:g" $report # change identity

  popd
  echo "Finished grading $name."
}

code_requirements_basic() {
  # CODE REQUIREMENTS:
  # Program must compile
  compile_strict "$name" "$report" a.out
  # No global variables
  count_globals "$name" "$report"
  # Program must not have any run-time faults
  no_runtime_errors a.out "$report"
}

code_requirements_full() {
  code_requirements_basic
  #  Destructors must deallocate dynamic memory
  leak_check a.out "$report"
}
