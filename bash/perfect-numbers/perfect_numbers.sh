#!/usr/bin/env bash

main() {
    number=$1
    
    ## error handling
    (( number < 1)) && echo "Classification is only possible for natural numbers." && exit 1
    (( number == 1 )) && echo "deficient" && exit 0
    
    ## calculate sum
    output=0
    for (( i=2; i*i<=number; i++ )); do
        if (( number % i == 0 )); then
            output=$(( output + i ))
            if (( i != number / i )); then
                output=$(( output + number / i ))
            fi
        fi
    done
    output=$((++output))

    ## print the output
    if (( output < number )); then
        echo "deficient"
    elif (( output == number )); then
        echo "perfect"
    elif (( output > number )); then
        echo "abundant"
    fi
}

main "$@"