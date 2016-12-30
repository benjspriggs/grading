#!/usr/bin/env bash
# Interactively unpacks and prepares a local directory
# similar to how a remote grading environment would be set up.
#
# Places all prepared directories in a new 'to_grade' directory
# next to the <source-dir> argument
# REQUIRES : move.sh
# usage: ./local-grade.sh <source-dir>

usage() {
  >&2 echo -e "usage: ./local-grade.sh <source-dir>"
  exit 1
}

[[ -z "$1" ]] && usage
[[ ! -d "$1" ]] && usage

source_dir="$( realpath $1 )"
dest="$(dirname $source_dir)"/to_grade
SCR_SOURCE="$( dirname $(realpath $0) )"
MOVE="${SCR_SOURCE%d2l}"move.sh

for file in "$source_dir"/*;
do
  if [[ ! -d "$file" ]]; then continue; fi
  file=$(realpath $file)
  name=$(basename $file)
  if [[ "$name" == "graded" ]]; then continue; fi
  echo
  echo "Processing $(basename $file)..."
  cd "$file"
  echo
  ls
  select fn in * "quit"; do
    case "$fn" in
      quit) 
        break
        ;;
      *) 
        echo "Using '$fn' as the student archive..."
        $MOVE -l "$dest" "$name" "$fn" # requires move.sh
        break
        ;;
    esac
  done
  cd ..
done
