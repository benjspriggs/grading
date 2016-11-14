#!/usr/bin/env bash
# An automated moving and makefile-adding script for CS202

HELP_MSG="Usage: grade (--help) name [archive]
This script takes an archive, opens it, adds a default makefile for general use,
and makes the extracted files available on the PSU linux systems."

# REQUIRES - GRADING_LOCAL, GRADING_REMOTE, LINUX, MAKEFILE
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ "$SOURCE" != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
PATHS=${DIR%$(basename "$SOURCE")}/paths.sh
source "$PATHS"
if [ -z ${GRADING_LOCAL+x} ] || [ -z ${GRADING_REMOTE+x} ] || [ -z ${LINUX+x} ] || [ -z ${MAKEFILE+x} ] ; then
  echo "$SOURCE"
  echo "$DIR"
  echo "Please install the path script ('path.sh') to $PATHS and update the following paths:
  GRADING_LOCAL
  GRADING_REMOTE
  LINUX
  MAKEFILE"
  exit 1
fi

# check for a help message in arguments
if [ -z "$1" -o -z "$2" ]; then
  echo "$HELP_MSG"
  exit 0
fi

for arg in $@; do
  if [ ["$arg"] == ["--help"] -o ["$arg"] == ["-h"] ]; then
    echo "$HELP_MSG"
    exit 0
  fi
done

NAME="$1" # name of the individual, folder where the extracted contents will go
ARCHIVE="$2" # archive name

put_makefile_in_dir() {
  count=$(ls -l *.cpp 2>/dev/null | wc -l)
  go_to_dir_with_cpp
  echo Moving makefile to $(pwd)/makefile...
  $(cat "$MAKEFILE" > "$(pwd)/makefile")
  cd "$GRADING_LOCAL"
}

go_to_dir_with_cpp() {
  amount_cpp='find . -type f -printf "%f\n" | grep .cpp -c'
  candidate=`eval $amount_cpp`

  for file in *; do
    if [ ! -d "$file" ]; then
      break
    fi
    cd "$file"
    current=`eval $amount_cpp`
    if [ "$current" -lt "$candidate" ]; then
      cd ..
    else
      go_to_dir_with_cpp
      break
    fi
  done
}

# TODO: Escape these
if [[ -e "$MAKEFILE" && -e "$ARCHIVE" ]]; then
  [ -d "$NAME" ] || mkdir "$NAME"
  # extract the archive to a folder
  echo "Extracting archive $ARCHIVE..."
  if [[ "$ARCHIVE" =~ \.zip$ ]]; then
    unzip "$ARCHIVE" -d "$NAME"
  elif [[ "$ARCHIVE" =~ \.tar || $"$ARCHIVE" =~ \.gz$ || "$ARCHIVE" =~ \.tgz || "$ARCHIVE" =~ \.bz2$ ]]; then
    tar xvf "$ARCHIVE" -C "$NAME"
  elif [[ "$ARCHIVE" =~ \.rar$ ]]; then
    unrar e "$ARCHIVE" "$NAME"
  else
    echo -e "Archive format of \"$ARCHIVE\" not recognized. \nMust be a zip, tar, bz2, or gz."
    rm -d "$NAME"
    exit 1
  fi
  # add a makefile to the folder
  put_makefile_in_dir

  # copy the folder to the linux directory
  echo Moving $NAME\...
  if $(scp -r "$GRADING_LOCAL"/"$NAME" $LINUX:$GRADING_REMOTE); then
    echo $NAME moved successfully to PSU Linux systems at $GRADING_REMOTE.
    echo Cleaning up the directory...
    rm -rf "$GRADING_LOCAL"/"$NAME"
    echo Done.
  fi
elif [[ -e "$ARCHIVE" ]]; then
  echo "Makefile doesn't exist. Add a makefile in $MAKEFILE."
  exit 1
elif [[ -e "$MAKEFILE" ]]; then
  echo "Archive \"$ARCHIVE\" doesn't exist."
  exit 1
fi

