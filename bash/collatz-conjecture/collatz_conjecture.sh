#!/usr/bin/env bash

main() {
    number=$1
    if (( number <= 0 )); then
        echo "Error: Only positive numbers are allowed"
        exit 1
    fi
    iteration=0
    while (( number > 1 )); do
        ((number % 2 == 0 )) && number=$(( number / 2 )) || number=$(( 3 * number + 1 ))
        (( iteration++ ))
    done
    echo $iteration
}

main "$@"