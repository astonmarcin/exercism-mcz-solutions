#!/bin/bash

for (( i=1; i<=${#1}; i++  )); do
	n=$((${#1}-i))
	echo -n "${1:$n:1}"
done;
echo
