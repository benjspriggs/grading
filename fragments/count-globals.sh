#!/usr/bin/env bash
# fragments/count-globals.sh
# Count the number of global variables in every file
# Dumps everything into the student report as a 'global report'
# take a bunch of cpp files as arguments

count_globals () {
  local usage="count_globals <report> <p-name> [<files-to-lint...]"

  # usage block
  {
    if [[ -z "$1" ]];then
      die "Missing report name" "$usage"
    fi

    if [[ -z "$2" ]];then
      die "Missing program name" "$usage"
    fi
  }

  local report="$1"
  # collect all of the cpp files to lint
  # (in $@, after the first argument)
  local files_to_lint=()
  for file in "${@:2}"; do
    if [[ $file =~ \.cpp ]]; then
      file=$(realpath "$file")
      file=${file%%.cpp}
      files_to_lint+=("$file")
    fi
  done

  if [[ ${#files_to_lint[@]} != 0 ]]; then
    # count the number of files
    echo -e "\t\t## Global Context Output" >> $report
    echo -e "Counted ${#files_to_lint[@]} file(s)." >> $report

    # lint the files
    for file in "${files_to_lint[@]}"; do
      if [ -z $file ]; then
        echo "Cannot have empty filenames."
        break
      fi

      if [ ! -f $file.cpp ]; then
        echo "File '$file.cpp' does not exist!"
        break
      fi

      # count the number of global variables
      # NM puts global constants in the B, D, G sections
      local globals=$( g++ -O0 -c "$file.cpp" && nm "$file.o" | grep ' [B,D,G] ' | wc -l )
      rm "$file.o"
      if [[ $globals -gt 0 ]]; then
        # get names and such of variables
        echo -e "Found $globals global variables in $file..." | tee -a $report
        echo "$file.cpp::" >> $report
        echo "$(g++ -O0 -c "$file.cpp" && nm "$file.o" | egrep ' [A-Z] ' | egrep -v ' [UTW] ')" >> $report
        rm $file.o
      fi
    done
  fi
}
