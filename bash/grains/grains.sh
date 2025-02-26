#!/usr/bin/env bash

main () {
    if [[ $1 == "total" ]]; then
        printf '%u' -1
    elif [[ $1 -ge 1 && $1 -le 64 ]]; then
        printf '%u'  $((2 ** ($1 - 1)))
    else
        echo "Error: invalid input"
        exit 1
    fi
}

main "$@"