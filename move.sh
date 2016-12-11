#!/usr/bin/env bash
# An automated moving and makefile-adding script for CS202
# usage: ./move.sh [-h] [-l (local dir)] [-n] name archive
# -h Display help text
# -l Local directory
# -n No clean

HELP_MSG="Usage: ./move.sh [-h] [-l (local dir)] [-n] name archive
This script takes an archive, opens it, adds a default makefile for general use,
and makes the extracted files available on the PSU linux systems."

# REQUIRES - GRADING_REMOTE, LINUX, MAKEFILE
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ "$SOURCE" != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
PATHS=${DIR%$(basename "$SOURCE")}/paths.sh
source "$PATHS"
if [ -z ${GRADING_REMOTE+x} ] || [ -z ${LINUX+x} ] || [ -z ${MAKEFILE+x} ] ; then
  echo "Please install the path script ('path.sh') to $PATHS and update the following paths:
  GRADING_REMOTE
  LINUX
  MAKEFILE"
  exit 1
fi

# parse some options
while getopts hl:n flag; do
  case $flag in
    h) 
      echo -e "$HELP_MSG"
      exit 0
      ;;
    l)
      local_dir="$( realpath ${OPTARG} )"
      ;;
    n) no_clean='true'
      ;;
    :) echo "got: $OPTARG";;
  esac
done
shift $((OPTIND - 1))

# check for a help message in arguments
if [ -z "$1" -o -z "$2" ]; then
  echo "$HELP_MSG"
  exit 1
fi

for arg in $@; do
  if [ ["$arg"] == ["--help"] -o ["$arg"] == ["-h"] ]; then
    echo "$HELP_MSG"
    exit 0
  fi
done

NAME="$1" # name of the individual, folder where the extracted contents will go
ARCHIVE="$2" # archive name
CWD="$(pwd)"

put_makefile_in_dir() {
  cd "$NAME"
  go_to_dir_with_cpp
  echo Moving makefile to $(pwd)/makefile...
  cp "$MAKEFILE" makefile
  cd "$CWD"
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

# validate the archive and makefile
_validate_archive_makefile(){
  if [[ -e "$ARCHIVE" && ! -e "$MAKEFILE" ]]; then
    echo "Makefile doesn't exist. Add a makefile in $MAKEFILE."
    exit 1
  elif [[ -e "$MAKEFILE"  && ! -e "$ARCHIVE" ]]; then
    echo "Archive \"$ARCHIVE\" doesn't exist."
    exit 1
  fi
}

# validate dir
_valid_destination(){
  if [ ! -z "${local_dir}" ];
  then
    return 0
  else
    return 1
  fi
}

# extract 
_extract_archive(){
  # create the archive if it doesn't exist
  [ -d "$NAME" ] || mkdir "$NAME"
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
}

_validate_archive_makefile

# extract the archive to a folder
_extract_archive

# add a makefile to the folder
put_makefile_in_dir

# copy the folder to the linux directory,
# or destination directory
echo Moving $NAME\...

if _valid_destination; then
  # move it the local destinaion
  [ -d "$local_dir" ] || mkdir "$local_dir"
  mv "$NAME" "$local_dir"
  echo "$NAME moved successfully to local dir '$local_dir'"
elif scp -r "$CWD"/"$NAME" $LINUX:$GRADING_REMOTE; then
  echo $NAME moved successfully to PSU Linux systems at $GRADING_REMOTE.
fi

if [ ! -z "$no_clean" ]; then 
  exit 0 
fi

# clean up
echo Cleaning up the directory...
rm -rf "$NAME"
echo Done.
