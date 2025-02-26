#!/usr/bin/env bash

encode () {
    for input in "$@"; do
        ## convert input from hex to bin
        input=$( bc <<< "ibase=16; obase=2; $input" )
        input_len=${#input}

        ## add padding zeroes - length should be multile of 7
        padding=$(( (7 - (input_len % 7)) % 7 ))
        input=$(for (( i=0; i<padding; i++)); do printf "0"; done)${input}
        input_len=$(( input_len + padding ))

        ## splitting input for 7 bits words
        for (( word=0; word<input_len; word+=7 )); do
            ## determine if it is last byte
            (( word == input_len - 7 )) && is_last=0 || is_last=1
            ## convert bin to hex and append
            hex=$(printf "%02s" "$( bc <<< "obase=16; ibase=2; ${is_last}${input:$word:7}")")
            hex=${hex// /0}
            output+=( "$hex" )
        done
    done

    echo "${output[@]}"
}

decode () {
    ## declare input variables
    input_len=${#@}
    declare -a output
    word=""
    idx=0

    ## iterate 
    for input in "$@"; do
        ## convert hex to bin and extract bit of a number
        binary=$( printf "%08d" "$( bc <<< "ibase=16; obase=2; $input" )" )
        is_last=${binary:0:1}
        word+=${binary:1:7}

        ## error handling - last hex must have 7th bit == 0
        (( is_last == 1 && idx == input_len - 1 )) && { echo "incomplete byte sequence"; exit 1; }

        ## 7th bit is 0? convert hex to bin and put to output array
        if (( is_last == 0 )); then
            hex=$(printf "%02s" "$( bc <<< "obase=16; ibase=2; ${word}")")
            hex=${hex// /0}
            output+=( "${hex}" )
            word=""
        fi
        (( idx += 1 ))
    done
    
    ## print output
    echo "${output[*]}"
}


main () {
    case $1 in
        "decode")
            shift
            decode "$@"
            ;;
        "encode")
            shift
            encode "$@"
            ;;
        *)
            echo "unknown subcommand"
            exit 1
            ;;
    esac
}

main "$@"