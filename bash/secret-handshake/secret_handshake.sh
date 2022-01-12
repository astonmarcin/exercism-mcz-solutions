#!/usr/bin/env bash

if [[ $# -ne 1 ]] || [[ $1 -gt 31 ]] || [[ $1 -lt 0 ]]; then
	echo "Usage: secret_handshake.sh <0-31>"
	exit 1
fi

bin=$( echo "ibase=A;obase=2;$1" | bc )
counter=${#bin}

for (( i=$counter-1; i>=0; i-- )); do
	position=$((${#bin}-$i-1))
	char=${bin:$i:1}

	if [[ $char -eq 1 ]]; then
		case $position in
			0) handshake_elements+=("wink") ;;
			1) handshake_elements+=("double blink") ;;
			2) handshake_elements+=("close your eyes") ;;
			3) handshake_elements+=("jump") ;;
			4) reverse=1 ;;
		esac
	fi
done

for (( i=0 ; i<=${#handshake_elements[@]}-1 ; i++ )); do
	if [[ $reverse -eq 1 ]]; then
		output+=("${handshake_elements[${#handshake_elements[@]}-1-$i]}")
	else
		output+=("${handshake_elements[$i]}")
	fi
done

IFS=,
echo "${output[*]}"
