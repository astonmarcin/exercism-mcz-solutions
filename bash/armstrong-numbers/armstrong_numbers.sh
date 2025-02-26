#!/usr/bin/env bash

main () {
    if [[ $# -ne 1 && $* =~ [0-9] ]]; then
        exit 1
    fi

    input=$1
    input_len=${#input}
    output=0
    
    for (( i=0; i<${#input}; i++)); do
        output=$(( output + ${input:$i:1} ** input_len ))
    done
    
    if [[ ${output} -eq ${input} ]]; then
        echo true
    else
        echo false
    fi
}

main "$@"