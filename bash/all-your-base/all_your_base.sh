#!/usr/bin/env bash

main () {
    ## declare variables
    input_base="$1"; shift
    IFS=" " read -r -a input <<< "$1"; shift
    (( input_len = ${#input[@]} - 1 ))
    output_base="$1"; shift

    ## error when base is less than 2
    (( input_base < 2 || output_base < 2 )) && { echo error; exit 1; }

    ## convert input digits into decimal number
    decimal=0
    for idx in "${!input[@]}"; do
        digit=${input[((input_len-idx))]}
        ## check if digit is within base boundary
        (( digit < 0 || digit >= input_base )) && { echo error; exit 1; }
        (( decimal += digit * ( input_base ** idx ) ))
    done

    ## converted number is 0? no further calcs need, just print 0 and exit
    (( decimal == 0 )) && { echo 0; exit 0; }

    ## calculate digits in output base...
    output=""
    while (( decimal > 0 )); do
        output="$(( decimal % output_base )) $output"
        (( decimal /= output_base ))
    done
    
    ## ..and print them
    echo $output

}

main "$@"