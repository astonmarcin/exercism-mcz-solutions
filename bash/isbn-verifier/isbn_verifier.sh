#!/usr/bin/env bash

end_script () {
    $1 && echo true || echo false
    exit 0
}

main () {
    ## init vars
    input_str="${1//-/}"
    (( ${#input_str} != 10 )) && end_script false
    declare -a input_array

    ## split ISBN digits to array
    for (( i=0; i<${#input_str}; i++ )); do
        char="${input_str:$i:1}"
        ## if char is not digit - false
        [[ $char =~ [^0-9X] ]] && end_script false
        ## X can be only the last digit
        [[ $char == "X" && $i == "9" ]] && input_array+=( 10 ) || input_array+=( "$char")
    done

    ## calculate checksum...
    output=0
    for (( i=10; i>0; i--)); do
        (( output += i * ${input_array[10-$i]} ))
    done

    ## ...check if is valid, and print output
    (( output % 11 == 0 )) && end_script true || end_script false
}

main "$@"