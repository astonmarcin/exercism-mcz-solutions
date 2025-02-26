#!/usr/bin/env bash

main () {
    ## init vars
    input=${1//[^a-zA-Z0-9]/}
    input=${input,,}
    input_len=${#input}
    declare -a output

    ## calculate number of rows and columns
    r=0
    c=1
    until (( c >= r && c - r <= 1 && c * r >= input_len )); do
        (( input_len == 0 )) && break
        (( r += 1 ))
        (( c = (input_len + r - 1) / r ))
    done

    ## put trailing spaces
    input+=$(printf "%$(( r * c - input_len ))s")

    ## and code input - get every letter, put in right order
    for (( i=0; i<c; i++ )); do
        temp=""
        for (( j=0; j<r; j++ )); do
            temp+="${input:j*c+i:1}"
        done
        output+=( "$temp" )
    done
    
    echo "${output[@]}"
}

main "$@"