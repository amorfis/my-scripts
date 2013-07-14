#!/bin/bash

DIR=$1
SOURCE_EXT=$2

if [ -z "$2" ] 
then
	SOURCE_EXT="MOV"
fi

echo "Working for files in directory: $DIR"
echo "Source file extension: $SOURCE_EXT"

for f in "$DIR"/* 
do
	fullname=$(basename "$f")
	name="${fullname%.*}"
	ext="${fullname##*.}"

	#Ommit source files
	if [ $ext = $SOURCE_EXT ]
	then
		continue
	fi

	originalMov=$DIR/$name.$SOURCE_EXT
	if [ -a "$originalMov" ]
	then
		echo "Original found: $originalMov"
		tmpDate=`stat -t '%Y%m%d%H%M%S' "$originalMov" | awk '{ print $12 }'`
		creationDate=`echo $tmpDate | sed -E 's/"([0-9]{12})([0-9]{2})"/\1.\2/'`
		echo "Setting $fullname creation date to $originalMov: $creationDate"

		touch -t $creationDate "$f"
	fi
done

