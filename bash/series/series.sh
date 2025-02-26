#!/usr/bin/env bash

main() {
    series=$1
    slice=$2

    ## error handling
    if [[ $series == "" ]]; then
        echo "series cannot be empty"
        exit 1
    elif (( slice > ${#series} )); then
        echo "slice length cannot be greater than series length"
        exit 1
    elif (( slice == 0 )); then
        echo "slice length cannot be zero"
        exit 1
    elif (( slice < 0 )); then
        echo "slice length cannot be negative"
        exit 1
    fi

    output=""
    for (( i=0; i<=${#series}-slice; i++ )); do
        output+="${series:$i:$slice} "
    done
    echo "${output%?}"
}

main "$@"