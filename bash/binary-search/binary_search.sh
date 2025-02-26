#!/usr/bin/env bash

main () {
    to_search="$1"; shift
    declare -a list
    while [[ -n $1 ]]; do
        list+=("$1")
        shift
    done

    for (( i=0; i<${#list[@]}; i++ )); do
        (( ${list[$i]} == to_search )) && { echo $i; exit 0; }
    done
    echo -1
}

main "$@"