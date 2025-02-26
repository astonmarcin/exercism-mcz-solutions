#!/usr/bin/env bash

main () {
    ## prepare variables
    lines=()
    max_line_len=0
    while IFS= read -r line; do
        lines+=("$line")
        (( ${#line} > max_line_len )) && max_line_len=${#line}
    done
    num_lines=${#lines[@]}

    ## add padding spaces
    for idx in "${!lines[@]}"; do
        line="${lines[$idx]}"
        len=${#line}
        for (( i=0; i<max_line_len-len; i++ )); do
            line+=" "
        done
        lines[idx]="$line"
    done

    ## traspose
    output=()
    for (( letter_idx=0; letter_idx<max_line_len; letter_idx++ )); do
        temp=
        for line in "${lines[@]}"; do
            temp+="${line:$letter_idx:1}"
        done
        output+=("$temp")
    done

    ## deal with trailing spaces - iterate backward, remove trailing spaces until reach line without spaces
    output_len=0
    for (( idx=${#output[@]}-1; idx>=0; idx-- )); do
        line=${output[$idx]}
        line_without_spaces="${line%"${line##*[![:space:]]}"}"
        len=${#line_without_spaces}
        (( len > output_len )) && output_len=$len
        (( len == num_lines )) && break
        temp=
        for (( i=0; i<output_len; i++ )); do
            temp+=${line:i:1}
        done
        output[idx]="$temp"
    done
    
    ## print the solution
    for line in "${output[@]}"; do
        echo "$line"
    done
}

main "$@"