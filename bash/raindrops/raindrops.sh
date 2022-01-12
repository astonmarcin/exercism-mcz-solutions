#!/usr/bin/env bash

sound=(Pling Plang Plong)

for i in 3 5 7; do
	modulo+=( $(( $1 % $i )) )
done

for (( i=0; i<=2; i++ )); do
	if [[ ${modulo[$i]} -eq 0 ]]; then
		output+=${sound[$i]}
	fi
done

output=${output:-$1}

echo "$output"
