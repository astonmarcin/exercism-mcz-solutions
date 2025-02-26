#!/usr/bin/env bash

main () {
    input=${1^^}
    counter=0
    alphabet=()
    for i in {0..25}; do
        alphabet+=(0)
    done
    for (( i=0; i<${#input}; i++ )); do
        letter_idx=0
        for letter in {A..Z}; do
            if [[ "${input:$i:1}" == "${letter}" ]]; then
                alphabet[${letter_idx}]=1
            fi
            (( letter_idx++ ))
        done
    done
    for i in "${alphabet[@]}"; do
        counter=$(( counter + i ))
    done
    [[ ${counter} -ge 26 ]] && echo true || echo false
}

main "$@"