#!/usr/bin/env bash

main () {
    input="$*"
    input=${input//-/ }
    input=${input//[^a-zA-Z ]/}
    output=""
    for word in $input; do
        output+=${word:0:1}
    done
    echo "${output^^}"
}

main "$@"