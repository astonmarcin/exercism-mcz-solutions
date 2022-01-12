#!/usr/bin/env bash

regex_opens="[[{(]"
regex_closes="[]})]"
opens_chars=""

for (( i=0; i<=${#1} ; i++ )); do
	actual_char=${1:$i:1}

	if [[ $actual_char =~ $regex_opens ]]; then
		opens_chars+=$actual_char
	elif [[ $actual_char =~ $regex_closes ]]; then
		case $actual_char in
			\]) char_to_compare="[" ;;
			\}) char_to_compare="{" ;;
			\)) char_to_compare="(" ;;
			*) echo false; exit 0 ;;
		esac

		if [[ "${opens_chars: -1}" == "$char_to_compare" ]]; then
			opens_chars=${opens_chars%?}
		else
			echo false
			exit 0
		fi
	fi
done

if [[ -n $opens_chars ]]; then
	echo false
	exit 0
fi

echo true
