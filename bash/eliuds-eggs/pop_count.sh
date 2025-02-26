#!/usr/bin/env bash

main() {
    bin_number=$(echo "obase=2;$1" | bc)
    counter=0
    for (( bit=0; bit<${#bin_number}; bit++ )); do
       (( ${bin_number:$bit:1} == 1)) && (( ++counter ))
    done
    echo $counter
}

main "$@"