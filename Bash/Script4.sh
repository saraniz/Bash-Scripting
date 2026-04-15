#!/bin/bash

file=$1

if [[ -z $file ]]
then
	echo "file is not exist" | tee -a Bash/results4.txt
	exit 1
else [[ -f $file ]]
	echo "$file is exist" | tee -a Bash/results4.txt
fi

errorc=0
infoc=0
warningc=0

while read -r line
do
	echo "$line" | tee -a Bash/results4.txt
	
	if [[ $line == *"ERROR"* ]]
	then
		((errorc++))
	elif [[ $line == *"INFO"* ]]
	then
		((infoc++))
	elif [[ $line == *"WARNING"* ]]
	then
		((warningc++))
	fi
done < log-analyzer/app.log

echo "Error count: $errorc" | tee -a Bash/results4.txt
echo "Info count: $infoc" | tee -a Bash/results4.txt
echo "Warning count: $warningc" | tee -a Bash/results4.txt
