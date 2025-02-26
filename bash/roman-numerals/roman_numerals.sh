#!/usr/bin/env bash

convert_matrix=(
    "M;1000"
    "CM;900"
    "D;500"
    "CD;400"
    "C;100"
    "XC;90"
    "L;50"
    "XL;40"
    "X;10"
    "IX;9"
    "V;5"
    "IV;4"
    "I;1"
)

main () {
    number="$1"
    output=""
    for num in "${convert_matrix[@]}"; do
        roman_number=${num%;*}
        arab_number=${num#*;}
        for _ in $(seq 1 $(( number / arab_number ))); do
            output+="$roman_number"
        done
        number=$(( number % arab_number ))
    done
    echo "$output"
}

main "$@"