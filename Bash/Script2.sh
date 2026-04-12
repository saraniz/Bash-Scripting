#!/bin/bash

#take user details
echo "Enter Your name:"
read name

echo "Enter Your age:"
read age

echo "Welcome $name to Bash Scripting lesson" | tee -a Bash/results2.txt
echo "$name age is $age" | tee -a Bash/results2.txt
echo "Today is $(date +%Y-%m-%d) & time is $(date +%H:%M:%S)" | tee -a Bash/results2.txt

if [[ $age -lt 18 ]]
then
	echo "$name is Minor" | tee -a Bash/results2.txt
elif [[ $age -gt 18 ]]
then
	echo "$name is Adult" | tee -a Bash/results2.txt
fi

echo "Enter Number"
read num

if (( num%2 == 0 ))
then
	echo "$num is even" | tee -a results2.txt
else 
	echo "$num is odd" | tee -a results2.txt
fi



