#!/usr/bin/env bash

main() {
    ## create arrays from given lists
    for number in ${1//[\[\],]/}; do
        list_1+=("$number")
    done
    for number in ${2//[\[\],]/}; do
        list_2+=("$number")
    done

    ## take them length of lists
    len_list_1=${#list_1[@]}
    len_list_2=${#list_2[@]}

    ## handle zero length
    if (( len_list_1 == 0 && len_list_2 == 0 )); then
        echo "equal"
        exit 0
    elif (( len_list_1 == 0 )); then
        echo "sublist"
        exit 0
    elif (( len_list_2 == 0 )); then
        echo "superlist"
        exit 0
    fi

    ## handle other scenarios
    if (( len_list_1 == len_list_2 )); then
        if [[ "${list_1[*]}" == "${list_2[*]}" ]]; then
            echo "equal"
            exit 0
        else
            echo "unequal"
            exit 0
        fi
    elif (( len_list_1 > len_list_2 )); then
        bigger_list=("${list_1[@]}")
        len_bigger_list=$len_list_1
        smaller_list=("${list_2[@]}")
        len_smaller_list=$len_list_2
        output="superlist"
    elif (( len_list_2 > len_list_1 )); then
        bigger_list=("${list_2[@]}")
        len_bigger_list=$len_list_2
        smaller_list=("${list_1[@]}")
        len_smaller_list=$len_list_1
        output="sublist"
    fi

    ## list length are not the same, decide if it is sub- or superlist
    for (( idx_big=0; idx_big<len_bigger_list; idx_big++ )); do
        if (( bigger_list[idx_big] == smaller_list[0]  )); then
            if [[ "${bigger_list[*]:$idx_big:$len_smaller_list}" == "${smaller_list[*]}" ]]; then
                echo "$output"
                exit 0
            else
                continue
            fi
        fi
    done
    
    ## none of two, so they are...
    echo "unequal"
    exit 0
}

main "$@"