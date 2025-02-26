#!/usr/bin/env bash

main () {
    ## declare alphabet
    lowcases="abcdefghijklmnopqrstuvwxyz"
    upcases="ABCDEFGHIJKLMNOPQRSTUVWXYZ"

    ## generate cipher
    declare -A cipher
    for (( idx=0; idx<=25; ++idx )); do
        cipher_idx=$(( ( $2 + idx ) % 26 ))
        cipher[${lowcases:$idx:1}]=${lowcases:$cipher_idx:1}
        cipher[${upcases:$idx:1}]=${upcases:$cipher_idx:1}
    done

    ## encrypt input
    output=
    for (( idx=0; idx<=${#1}-1; ++idx )); do
        letter=${1:$idx:1}
        if [[ $upcases$lowcases == *$letter* ]]; then
            output+=${cipher[$letter]}
        else
            output+=$letter
        fi
    done
    echo "$output"
}

main "$@"