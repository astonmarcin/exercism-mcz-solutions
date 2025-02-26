#!/usr/bin/env bash

if (( "$#" < 2 )); then
	echo "invalid color"
	exit 1
fi

for i in 1 2; do
	case ${!i} in
		black) output+="0";;
		brown) output+="1";;
		red) output+="2";;
		orange) output+="3";;
		yellow) output+="4";;
		green) output+="5";;
		blue) output+="6";;
		violet) output+="7";;
		grey) output+="8";;
		white) output+="9";;
		*) echo "invalid color"; exit 1;;
	esac
done

if [[ $output =~ ^0 ]]; then
    output=${output:1}
fi
    

echo $output
