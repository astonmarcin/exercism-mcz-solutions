#!/usr/bin/env bash

main() {
    input=$1
    span=$2

    ## error handling
    if (( span > ${#input} )); then
        echo "span must be smaller than string length"
        exit 1
    elif [[ $input =~ [^0-9]+ ]]; then
        echo "input must only contain digits"
        exit 1
    elif (( span < 0 )); then
        echo "span must not be negative"
        exit 1
    fi

    max_product=0
    for (( i=0; i<=${#input}-span; i++ )); do
        series="${input:$i:$span}"
        product=1
        for (( digit=0; digit<span; digit++ )); do
            product=$((product * ${series:$digit:1}))
        done
        if (( product > max_product )); then
            max_product=$product
        fi
    done
    echo "$max_product"
}

main "$@"