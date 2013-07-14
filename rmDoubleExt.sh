#!/bin/bash

DIR=$1

echo "Working for files in directory: $DIR"

for f in "$DIR"/* 
do
	fullname=$(basename "$f")
	ext="${fullname##*.}"
	
	if [[ $fullname =~ .*(\.$ext){2,} ]]
	then
		dirWithBase="${f%%.$ext*}"
		newName="$dirWithBase.$ext"
		echo "Found doubled extension: $f Changing to: $newName"
		mv "$f" "$newName" 
	fi
done
