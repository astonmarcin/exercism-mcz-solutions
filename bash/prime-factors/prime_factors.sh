#!/usr/bin/env bash

main() {
    [[ $1 -lt 2 ]] && exit 0
    number=$1
    output=""
    for (( div=2; div*div<=number; div++ )); do
        if [[ $(( number % div )) -eq 0 ]]; then
            output+="$div "
            number=$(( number / div ))
            div=$(( div - 1 ))
        fi
    done
    echo "${output}${number}"
}

main "$@"