#!/usr/bin/env bash

get_primes () {
    output=( $(seq 2 $1) )
    (( len_output = ${#output[@]} ))
    (( output_elem_idx = 0 ))
    while (( ( value = output[output_elem_idx] ) && value * value <= $1 )); do
        for (( idx = output_elem_idx + 1; idx < len_output; ++idx )); do
            if (( output[idx] % value == 0 )); then
                unset output[idx]
            fi
        done
        output=( ${output[*]} )
        (( output_elem_idx++ ))
    done
    echo "${output[*]}"
}

main () {
    (( $1 < 1 )) && { echo "invalid input"; exit 1; }
    
    total=0
    number="$1"
    factor=2
    primes=()

    while (( total < number )); do
        primes_no=$(( number * factor ))
        primes=( $(get_primes $primes_no ) )
        total=${#primes[@]}
        (( factor += 1 ))
    done

    echo "${primes[number-1]}"
}

main "$@"