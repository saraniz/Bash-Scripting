#!/bin/bash

if [ -z "$1" ]
then
	echo "No file" | tee -a Bash/results3.txt
 	exit 1
fi

file=$1

if [ -f "$file" ]
then
	echo "File exists: $file" | tee -a Bash/results3.txt
	echo "Number of lines : $(wc -l < "$file")" | tee -a Bash/results3.txt
	echo "Number of words: $(wc -w < "$file")" | tee -a Bash/results3.txt
else
	echo "Error: $file not found" | tee -a results3.txt
	exit 1
fi
