#!/usr/bin/env bash

generate_private () {
    random=$(od -An -N2 /dev/urandom)
    echo "$(( (${random// /} % ( $1 - 1) ) + 2))"
}

main () {
    case $1 in
        "privateKey") 
            shift; generate_private "$1"
            ;;
        "publicKey"|"secret") 
            shift; bc <<< "$2"^"$3"%"$1"
            ;;
        *)
            exit 1 ;;
    esac
}

main "$@"