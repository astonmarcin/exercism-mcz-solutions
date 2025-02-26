#!/usr/bin/env bash

function modifier {
	if [[ "$1" -lt 3 ]] || [[ "$1" -gt 18 ]]; then
		echo "Usage: $0 modifier <3-18>"
	fi

	modifier_output=$( bc <<< "$1/2-10/2")
	echo -e "${modifier_output}"
}

function dice_roll {
	for i in {0..3}; do
		dice_roll_array+=($((RANDOM%6+1)))
	done
	dice_roll_output=()
	while IFS='' read -r line; do
	    dice_roll_output+=("${line}")
	done < <(printf "%s\n" "${dice_roll_array[@]}" | sort -nr | head -n3)
	unset dice_roll_array
}

function generate {
	for i in {0..5}; do
		dice_roll
		skill+=($(( dice_roll_output[0] + dice_roll_output[1] + dice_roll_output[2] )))
		unset dice_roll_output
	done

	skill+=($(( 10 + $(modifier "${skill[2]}") )))

	for i in {0..6}; do
		case $i in
			0) generate_output+="strength ${skill[0]}\n" ;;
			1) generate_output+="dexterity ${skill[1]}\n" ;;
			2) generate_output+="constitution ${skill[2]}\n" ;;
			3) generate_output+="intelligence ${skill[3]}\n" ;;
			4) generate_output+="wisdom ${skill[4]}\n" ;;
			5) generate_output+="charisma ${skill[5]}\n" ;;
			6) generate_output+="hitpoints ${skill[6]}" ;;
			*) exit 1 ;;
		esac
	done
	echo -e "$generate_output"
}

function main {
	if [[ "$1" == "modifier" ]]; then
		modifier "$2"
		exit 0
	elif [[ "$1" == "generate" ]]; then
		generate
		exit 0
	else
		echo "Usage:"
		echo "$0 modifier <3-18>"
		echo "$0 generate"
		exit 0
	fi
}

main "$@"