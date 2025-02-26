#!/usr/bin/env bash
shopt -s extglob

main() {
    ## declace array for output data
    declare -A word_count
    declare -a order

    ## splitting sentence to words
    words="${1//+([^[:alnum:]\'])/_}"
    words="${words//_\'/ }"
    words="${words//\'_/ }"
    [[ ${words:0:1} == "'" ]] && words=${words:1}
    [[ ${words: -1} == "'" ]] && words=${words%?}
    words="${words//_/ }"

    ## counting words
    for word in $words; do
        word_lowcase=${word,,}
        (( word_count[${word_lowcase}]++ )) 
        if ((  word_count[${word_lowcase}] == 1 )); then
            order+=("${word_lowcase}")
        fi
    done

    ## print them out!
    for word in "${order[@]}"; do
        echo "${word}: ${word_count[${word}]}"
    done 
}

main "$@"