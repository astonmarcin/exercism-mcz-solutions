#!/usr/bin/env bash

verse() {
    bottles_on_wall=${1}
    if (( bottles_on_wall == 1 )); then
        minus_one="no more"
    else 
        minus_one=$(( (bottles_on_wall - 1 + 100) % 100 ))
    fi
    how_many_left="$minus_one bottles"
    if (( bottles_on_wall > 1 )); then
        s="s"
        what_to_do="Take one down and pass it around"
        (( minus_one == 1 )) && how_many_left=${how_many_left::-1}
    elif (( bottles_on_wall == 1 )); then
        s=""
        what_to_do="Take it down and pass it around"
    elif ((  bottles_on_wall == 0 )); then
        bottles_on_wall="No more"
        s="s"
        what_to_do="Go to the store and buy some more"
    fi
    text="${bottles_on_wall} bottle${s} of beer on the wall, ${bottles_on_wall,,} bottle${s} of beer.\n"
    text+="$what_to_do, ${how_many_left} of beer on the wall."
    echo "$text"
}

main() {
    if (( $# < 1 || $# > 2 )); then
        echo "1 or 2 arguments expected"
        exit 1
    fi
    if (( $# == 1 )); then
        start="$1"
        finish="$1"
    else
        start="$2"
        finish="$1"
    fi
    if (( start > finish )); then
        echo "Start must be greater than End"
        exit 1
    fi
    output=""
    for (( i=finish; i>=start; --i )); do
        output+=$(verse $i)"\n\n"
    done
    echo -e "$output"
}

main "$@"