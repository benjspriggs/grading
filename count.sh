#!/usr/bin/env bash
# calculates deductions
# from a score of 100

# needs filename
[[ -z "$1" ]] && exit 1

calc_deductions() {
  col=$(( $2 )) ;
  for num in `grep -Eo '[0-9]+' "$1"`; do 
    col=$(($col-$num));
  done;
  return $col
}
calc_deductions "$1" 100
echo $?
