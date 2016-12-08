#!/usr/bin/env bash
# unzips a packaged D2l file
# places student work into unique directories
# and adds 'graded' folder to store already graded work
# usage: ./sort-files <d2l-zip>

# require zip path
[[ -z "$1" ]] && >&2 echo 'usage: ./sort-files <d2l-zip>' && exit 1

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
