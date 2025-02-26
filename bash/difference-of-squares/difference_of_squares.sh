#!/usr/bin/env bash

square_of_sum () {
    output=0
    for (( i=1; i<=$1; i++ )); do
        output=$(( output + i ))
    done
    echo $(( output * output ))
}

sum_of_squares () {
    output=0
    for (( i=1; i<=$1; i++ )); do
        output=$(( output + ( i * i ) ))
    done
    echo $output
}

main () {
    case $1 in
        "square_of_sum")
            shift
            square_of_sum "$1"
            ;;
        "sum_of_squares")
            shift
            sum_of_squares "$1"
            ;;
        "difference")
            shift
            sum=$(sum_of_squares "$1")
            sqr=$(square_of_sum "$1")
            echo $(( sqr - sum ))
            ;;
        *)
            exit 1
            ;;
    esac
}

main "$@"