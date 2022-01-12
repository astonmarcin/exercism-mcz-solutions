#!/usr/bin/env bash

declare -A raw_data_array

for i in 1 2 3; do
        case ${!i} in
                black) raw_data_array[$i]="0";;
                brown) raw_data_array[$i]="1";;
                red) raw_data_array[$i]="2";;
                orange) raw_data_array[$i]="3";;
                yellow) raw_data_array[$i]="4";;
                green) raw_data_array[$i]="5";;
                blue) raw_data_array[$i]="6";;
                violet) raw_data_array[$i]="7";;
                grey) raw_data_array[$i]="8";;
                white) raw_data_array[$i]="9";;
                *) echo "ERROR!"; exit 1;;
        esac
done

raw_data+="${raw_data_array[1]}""${raw_data_array[2]}"

for (( i=1; i<=${raw_data_array[3]}; i++ )); do
	raw_data+="0"
done


modulo=0
prefix=0
ohms=$( bc <<< "$raw_data" )

if [[ $ohms -eq 0 ]]; then
	modulo=1
else
	modulo=$( bc <<< "$raw_data % 1000" )
fi

while [[ $modulo -eq 0 ]]; do
	prefix=$(( prefix+1 ))
	ohms=$( bc <<< "$ohms / 1000" )
	modulo=$( bc <<< "$ohms % 1000" )
done

case $prefix in
	0) output="$ohms ohms" ;;
	1) output="$ohms kiloohms" ;;
	2) output="$ohms megaohms" ;;
	3) output="$ohms gigaohms" ;;
	*) echo ERROR!; exit 1 ;;
esac
	
echo $output
