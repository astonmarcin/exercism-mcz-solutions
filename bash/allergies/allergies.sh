#!/usr/bin/env bash

allergens=(
    "cats"
    "pollen"
    "chocolate"
    "tomatoes"
    "strawberries"
    "shellfish"
    "peanuts"
    "eggs"
)

main() {
    decimal_to_binary=({0..1}{0..1}{0..1}{0..1}{0..1}{0..1}{0..1}{0..1})
    number=${decimal_to_binary[$(( $1 % 256 ))]}; shift

    ## decide what to do
    if [[ "$1" == "list" ]]; then
        allergic_to_check=""
    elif [[ "$1" == "allergic_to" ]]; then
        shift
        allergic_to_check="$1"
    fi

    ## prepare list of allergens depending on input
    allergic_list=""
    for (( i=0; i<${#number}; i++ )); do
        char=${number:$i:1}
        if (( char == 1 )); then
            allergic_list="${allergens[$i]} "${allergic_list}
        fi
    done
    
    ## output the data
    if [[ $allergic_to_check == "" ]]; then
        echo "${allergic_list%?}"
    elif [[ $allergic_list =~ .*${allergic_to_check}.* ]]; then
        echo true
    else
        echo false
    fi
}

main "$@"