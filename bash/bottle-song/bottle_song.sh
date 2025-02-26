#!/usr/bin/env bash

num_bottles=(
    "No green bottles"
    "One green bottle"
    "Two green bottles"
    "Three green bottles"
    "Four green bottles"
    "Five green bottles"
    "Six green bottles"
    "Seven green bottles"
    "Eight green bottles"
    "Nine green bottles"
    "Ten green bottles"
)

main () {
    (( $# != 2 )) && { echo "2 arguments expected"; exit 1; }
    (( $1 < $2 )) && { echo "cannot generate more verses than bottles"; exit 1; }
    verse="$1"
    bottles="$2"

    output=()
    for (( i=0; i<bottles; i++ )); do
        output+=("${num_bottles[verse-i]} hanging on the wall,")
        output+=("${num_bottles[verse-i]} hanging on the wall,")
        output+=("And if one green bottle should accidentally fall,")
        output+=("There'll be ${num_bottles[verse-i-1],,} hanging on the wall.")
        output+=("")
    done

    for i in "${output[@]}"; do
        echo "$i"
    done
}

main "$@"