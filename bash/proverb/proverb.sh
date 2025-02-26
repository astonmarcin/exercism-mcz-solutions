#!/usr/bin/env bash

main() {
    if [[ $# -eq 0 ]]; then
        exit 0
    fi
    first=$1
    while [[ -n $2 ]]; do
        echo "For want of a $1 the $2 was lost."
        shift
    done
    echo "And all for the want of a $first."
}

main "$@"