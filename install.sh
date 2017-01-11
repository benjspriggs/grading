#!/usr/bin/env bash
# Install script for the grading script

echo "Making a 'path.sh' file in the grading folder..."
grading_folder="$(dirname $(realpath $0))"
pushd .
cd "$grading_folder"
touch paths.sh
echo -e "#!/usr/bin/env bash
# Paths for the grading scripts for PSU CS{162,163,202} courses
# Place your paths here
GRADING_LOCAL= # local directory of the grading folder
MAKEFILE=$grading_folder/makefile.example # makefile to be placed/ used for each student
LINUX= # remote linux ssh login (user@linux.cs.pdx.edu) or comparable ssh alias
GRADING_REMOTE= # remote directory of the grading folder" > paths.sh
echo "Add relevant paths for use by the scripts in 'path.sh'."
popd
