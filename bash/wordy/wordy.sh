#!/usr/bin/env bash

shopt -s extglob

process_number () {
    case $word in
        ## var is truly number
        +([0-9-]))
            if [[ -z $operation ]]; then
                ## no math operation yet, this is first number
                output="$word"
            else
                ## there is some math opertor, do the calculation
                calculation="$output $operation $word"
                output=$(( calculation ))
            fi
            ;;
        ## "What" is allowed as the first word of command
        What)
            (( idx != 0 )) && { echo "syntax error"; exit 1; } ;;
        ## math operators are not allowed, raise syntax error
        @(plus|minus|multiplied_by|divided_by|"?"))
            echo "syntax error"
            exit 1
            ;;
        ## any other value - raise unknown operation
        *)
            echo "unknown operation"
            exit 1
            ;;
    esac
}
process_operation () {
    word="$1"
    case $word in
        ## there are for allow math operations, convert them to sign
        plus)
            operation="+" ;;
        minus)
            operation="-" ;;
        multiplied_by)
            operation="*" ;;
        divided_by)
            operation="/" ;;
        ## "?" is allowed at a end of command
        "?")
            (( idx != input_length - 1 )) && { echo "syntax error"; exit 1; } ;;
        ## "is" is allowed as the second word of command
        is)
            (( idx != 1 )) && { echo "syntax error"; exit 1; } ;;
        ## numbers are not allowed, raise syntax error
        +([0-9-])) 
            echo "syntax error"
            exit 1
            ;;
        ## any other value - raise unknown operation
        *) 
            echo "unknown operation"
            exit 1
            ;;
    esac
}

main () {
    ## var initiation
    input_string="$1"
    input_string="${input_string//multiplied by/multiplied_by}"
    input_string="${input_string//divided by/divided_by}"
    input_string="${input_string//"?"/" ?"}"
    IFS=" " read -r -a input_array <<< "$input_string"
    input_length=${#input_array[@]}

    ### let's parse input
    output=0
    operation=""
    for (( idx=0; idx<input_length; idx++ )); do
        word=${input_array[$idx]}
        if (( idx % 2 == 0 )); then
            ## index is even - the word should be a number, make calculation
            process_number "$output" "$operation" "$word"
        else
            ## index is odd - the word should be a math operation
            process_operation "$word"
        fi
    done
    
    ## show calculated value
    echo "$output"
}

main "$@"