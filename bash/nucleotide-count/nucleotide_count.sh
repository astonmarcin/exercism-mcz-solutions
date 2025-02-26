#!/usr/bin/env bash

main () {
    declare -A output=( ["A"]=0 ["C"]=0 ["G"]=0 ["T"]=0 )
    for (( idx=0; idx<${#1}; ++idx )); do
       letter=${1:$idx:1}
       if [[ $letter =~ [ACGT] ]]; then
            (( ++output[$letter] ))
        else
            echo "Invalid nucleotide in strand"
            exit 1
        fi
    done
    for letter in "${!output[@]}"; do
        echo $letter: ${output[$letter]}
    done | sort 
}

main "$@"