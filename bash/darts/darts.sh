#!/usr/bin/env bash

check_regex='^-?[0-9]+(\.[0-9]+)? -?[0-9]+(\.[0-9]+)?$'

if ! [[ $* =~ $check_regex ]]; then
	echo ERROR!
	exit 1
fi

x=$1
y=$2

#radius = sqrt(x^2 + y^2)
radius=$(echo "scale=2;sqrt($x^2+$y^2)" | bc)

if (( $( echo "$radius > 10" | bc ) )); then
	score=0
elif (( $( echo "$radius > 5" | bc ) )); then
	score=1
elif (( $( echo "$radius > 1" | bc ) )); then
	score=5
else
	score=10
fi

echo "$score"
