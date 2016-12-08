#!/usr/bin/env bash

[[ -z "$1" ]] && exit 1

basename=all
files="$basename/*"
patt="([0-9]+-[0-9]+) - ([a-Z]+) ([a-Z]+)"

mkdir "$basename"
unzip $1 -d "$basename"
for f in $files
do
	if [[ "$f" =~ $patt ]]
	then
		id="${BASH_REMATCH[1]}"
		name_f="${BASH_REMATCH[2]}"
		name_p="${BASH_REMATCH[3]}"
		abbr="${name_f:0:1}${name_p}"
		nf="${f/$id - $name_f $name_p }"
		mkdir -p ""$basename"/$abbr"
		mv "$f" "$nf" 
		mv "$nf" ""$basename"/$abbr"
	fi
done

rename 'y/A-Z/a-z/' $files
mkdir ""$basename"/graded"
