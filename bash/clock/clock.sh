#!/usr/bin/env bash

main () {
    ## args handling
    input=()
    while (( $# )); do
        if (( ${#input[*]} > 1 )); then
            echo "invalid arguments: too many argument"
            exit 1
        fi
        if ! [[ $1 =~ ^-?[0-9]+$ ]]; then
            echo "invalid arguments: $1 is not a numeric"
            exit 1
        fi
        if [[ $1:$2:$3 =~ ^-?[0-9]+:[+-]:-?[0-9]+$ ]]; then
            input+=( $(($1 $2 $3)) )
            shift 3
        fi
        if [[ $1 =~ ^-?[0-9]+$ ]]; then
            input+=("$1")
            shift
        fi
    done
    if (( ${#input[*]} != 2 )); then
        echo "invalid arguments"
        exit 1
    fi
    
    ## let's calculate!
    (( minutes_modulo = input[1] % 60 ))
    (( minutes_divided = input[1] / 60 ))
    if (( input[1] < 0 && minutes_modulo != 0 )); then
        (( --minutes_divided ))
    fi

    (( hours_modulo = input[0] % 24 ))

    (( output_minutes =  ( 60 + minutes_modulo ) % 60 ))
    (( output_hours = ( 24 + ( minutes_divided + hours_modulo ) % 24 ) % 24 ))

    ## output the digital clock
    printf %02d:%02d\\n $output_hours $output_minutes
}

main "$@"