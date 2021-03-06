#!/bin/bash

if ! [[ $@ =~ ^[0-9]+$ ]]; then
	echo "Usage: leap.sh <year>"
	exit 1
fi

if [[ $(($1 % 4)) -eq 0 ]]; then
	if [[ $(($1 % 100)) -eq 0 ]]; then
		if [[ $(($1 % 400)) -eq 0 ]]; then
			echo true
		else
			echo false
		fi
	else
		echo true
	fi
else
	echo false
fi
