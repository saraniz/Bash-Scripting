#!/bin/bash

filename=$1
echo "File name is $filename" | tee -a results1.txt

error_count=$(grep -c "ERROR" log-analyzer/app.log) | tee -a results1.txt
warning_count=$(grep -c "WARNING" log-analyzer/app.log) | tee -a results1.txt

echo "Error count: $error_count"
echo "Warning count: $warning_count"

ecount=0
wcount=0

#using loops
while read -r line
do 
	if [[ $line == *"ERROR"* ]]; then
		((ecount++))
	elif [[ $line == *"WARNING"* ]]; then
		((wcount++))
	fi
done < log-analyzer/app.log

#extract only error messages
#/ERROR/ get lines only contain error
# $1=$2=$3="" mean first three words equal to empty string that mean they removes
#$0 take remain last word
awk '/ERROR/ { $1=$2=$3=""; print $0}' log-analyzer/app.log | tee -a results1.txt

#using loops
#cut used to extract partspf each line
#-d' ' -d mean delimeter(seperator) so here split the line using spaces
#-f mean fields and 4- mean from field 4 to the end
#give everything starting from column 4
while read -r line
do
if [[ $line == *"ERROR"* ]]; then
	echo "$line" | cut -d' ' -f4-
	fi
done < log-analyzer/app.log


echo "Most frequent errors" | tee - results1.txt

#sort sort the lines in alphabetical order
# uniq remove duplicates and -c take the counts
# -n numeric sort and -r reverse order(largest first)
# head -1 tae first line
grep "ERROR" log-analyzer/app.log | cut -d' ' -f4- | sort | uniq -c | sort -nr | head -1 | tee -a results1.txt

