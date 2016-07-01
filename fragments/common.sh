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
