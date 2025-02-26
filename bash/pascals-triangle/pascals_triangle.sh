#!/usr/bin/env bash

main () {
    declare -a pascal_triangle
    for (( row=0; row<$1; row++ )); do
        if (( ${#pascal_triangle} == 0 )); then
            pascal_triangle+=( 1 )
            continue
        fi
        IFS=" " read -r -a previous <<< "${pascal_triangle[$row-1]}"
        previous_len=${#previous[@]}
        next=()
        for (( idx=0; idx<=previous_len; idx++ )); do
            (( idx -1 < 0 )) && left=0 || left="${previous[idx-1]}"
            [[ -z ${previous[idx]} ]] && right=0 || right="${previous[idx]}"
            next+=( $(( left + right )) )
        done
        pascal_triangle+=( "${next[*]}" )
    done

    for (( row=0; row<$1; row++ )); do
        for (( space=0; space<$1-row-1; space++ )); do
            echo -n " "
        done
        echo "${pascal_triangle[row]}"
    done
}

main "$@"