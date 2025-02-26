#!/usr/bin/env bash

is_triange() {
    for num in "$@"; do
        if (( $( echo "$num == 0" | bc -l) )); then
            echo false
            exit 0
        fi
    done
    if (( $(echo "$1 + $2 < $3" | bc -l) || $(echo "$2 + $3 < $1" | bc -l) || $(echo "$3 + $1 < $2" | bc -l) )); then
        echo false
        exit 0
    fi
}

equilateral() {
    if (( $(echo "$1 != $2" | bc -l) || $(echo "$2 != $3" | bc -l) || $(echo "$3 != $1" | bc -l) )); then
        echo false
        exit 0
    fi
}

isosceles() {
    if ! (( $(echo "$1 == $2" | bc -l) || $(echo "$2 == $3" | bc -l) || $(echo "$3 == $1" | bc -l) )); then
        echo false
        exit 0
    fi
}

scalene() {
    if (( $(echo "$1 == $2" | bc -l) || $(echo "$2 == $3" | bc -l) || $(echo "$3 == $1" | bc -l) )); then
        echo false
        exit 0
    fi
}

main () {
    [[ "$#" -ne 4 ]] && exit 1
    to_check="$1"
    shift
    is_triange "$@"
    case $to_check in
        "equilateral")
            equilateral "$@"
            ;;
        "isosceles")
            isosceles "$@"
            ;;
        "scalene")
            scalene "$@"
            ;;
        *)
            exit 1
            ;;
    esac
    echo true
}


main "$@"