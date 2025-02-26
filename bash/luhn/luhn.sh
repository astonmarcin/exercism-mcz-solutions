#!/usr/bin/env bash

main() {
    input_number=${1// }
    output_sum=0

    [[ ! "$input_number" =~ ^[0-9]+$ ]] || (( ${#input_number} < 2 )) && echo false && exit 0

    (( ${#input_number} % 2 != 0 )) && input_number=0${input_number}

    for (( idx=0; idx<${#input_number}; idx++ )); do
        char=$((${input_number:$idx:1}))
        (( idx % 2 == 0 )) && (( char*=2 )) && (( char > 9 )) && (( char-=9 ))
        (( output_sum+=char ))
    done

    (( output_sum % 10 == 0 )) && echo true || echo false
}

main "$@"