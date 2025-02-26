#!/usr/bin/env bash

main () {
    ## initialize data
    operation="$1"
    string="$2"
    string_length="${#string}"
    letter_idx=0

    ## proceed with selected operation
    case $operation in
        "encode")
            while (( letter_idx < string_length )); do
                count=1
                ## take each letter
                letter=${string:$letter_idx:1}

                ## if it is repeating - count it
                while [[ "${string:((++letter_idx)):1}" == "$letter" ]]; do
                    (( count += 1 ))
                done

                ## and write to output - number of count and the letter
                (( count == 1 )) && echo -n "${letter}" || echo -n "${count}${letter}"
            done
            ;;
        "decode")
            while (( letter_idx < string_length )); do
                count=

                ## collect the number of repetitions
                while [[ ${string:$letter_idx:1} =~ ^[0-9]$ ]]; do
                    count+="${string:$letter_idx:1}"
                    (( letter_idx += 1 ))
                done

                ## get the letter
                letter=${string:$letter_idx:1}
                [[ $count == "" ]] && count=1
                
                ## and write it to output $count'th times
                for (( i=0; i<count; i++ )); do
                    echo -n "$letter"
                done

                (( letter_idx += 1 ))
            done
            ;;
    esac
}

main "$@"