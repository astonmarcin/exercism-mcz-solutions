#!/usr/bin/env bash

shopt -s nocasematch

main () {
    score=0
    for (( i=0; i<${#1}; i++ )); do
        if [[ ${1:$i:1} =~ [AEIOULNRST] ]]; then
            score=$(( score + 1 ))
        elif [[ ${1:$i:1} =~ [DG] ]]; then
            score=$(( score + 2 ))
        elif [[ ${1:$i:1} =~ [BCMP] ]]; then
            score=$(( score + 3 ))
        elif [[ ${1:$i:1} =~ [FHVWY] ]]; then
            score=$(( score + 4 ))
        elif [[ ${1:$i:1} =~ [K] ]]; then
            score=$(( score + 5 ))
        elif [[ ${1:$i:1} =~ [JX] ]]; then
            score=$(( score + 8 ))
        elif [[ ${1:$i:1} =~ [QZ] ]]; then
            score=$(( score + 10 ))
        fi
    done
    echo $score
}

main "$@"
