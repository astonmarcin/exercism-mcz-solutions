#!/usr/bin/env bash

shopt -s extglob

suffix_map=(
    ""
    "thousand"
    "million"
    "billion"
)
number_map=(
    ""
    "one"
    "two"
    "three"
    "four"
    "five"
    "six"
    "seven"
    "eight"
    "nine"
)
teens_map=(
    "ten"
    "eleven"
    "twelve"
    "thirteen"
    "fourteen"
    "fifteen"
    "sixteen"
    "seventeen"
    "eighteen"
    "nineteen"
)
tys_map=(
    ""
    ""
    "twenty"
    "thirty"
    "forty"
    "fifty"
    "sixty"
    "seventy"
    "eighty"
    "ninety"
)

main () {
    number="$1"
    (( number < 0 || number >= 1000000000000 )) && { echo "input out of range"; exit 1; }

    ## break number into 3-digits
    number_arr=()
    while (( number > 0 )); do
        number_arr+=( $(( number % 1000 )) )
        (( number /= 1000 ))
    done

    number_len=${#number_arr[@]}
    (( number_len == 0 )) && { echo "zero"; exit 0; }

    output=""
    for (( idx=number_len-1; idx>=0; idx-- )); do
        num=${number_arr[idx]}
        suf=${suffix_map[idx]}
        (( num == 0 )) && continue

        ## break into digits
        digits=()
        for (( i=2; i>=0; i-- )); do
            digits+=( $(( num / 10**i )) )
            (( num %= 10**i ))
        done

        ## hundreds
        if (( digits[0] > 0 )); then
            output+="${number_map[digits[0]]} hundred "
        fi
        ## twenty to ninety
        if (( digits[1] >= 2 && digits[1] <= 9 )); then
            (( digits[2] > 0 )) && output+="${tys_map[digits[1]]}-${number_map[digits[2]]} "
            (( digits[2] == 0 )) && output+="${tys_map[digits[1]]} "
        fi
        ## teens
        if (( digits[1] == 1 )); then
            output+="${teens_map[digits[2]]} "
        fi
        ## ones
        if (( digits[1] == 0 && digits[2] > 0 )); then
            output+="${number_map[digits[2]]} "
        fi
        ## suffix
        [[ $suf != "" ]] && output+="$suf "
        
    done

    echo "${output%?}"
}

main "$@"