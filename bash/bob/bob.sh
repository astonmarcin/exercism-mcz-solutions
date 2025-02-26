#!/usr/bin/env bash

main () {
    if [[ "${*}" =~ ^[[:space:]]*$ ]]; then
        echo "Fine. Be that way!"
    elif [[ "${*}" =~ ^[^a-z]*[A-Z][^a-z]*\? ]]; then
        echo "Calm down, I know what I'm doing!"
    elif [[ "${*}" =~ ^[^a-z]*[A-Z][^a-z]*$ ]]; then
        echo "Whoa, chill out!"
    elif [[ "${*}" =~ ^.+\?[[:space:]]*$ ]]; then
        echo "Sure."
    else 
        echo "Whatever."
    fi
}

main "$@"