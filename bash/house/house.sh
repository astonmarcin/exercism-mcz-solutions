#!/usr/bin/env bash

nouns=(
    "house that Jack built"
    "malt"
    "rat"
    "cat"
    "dog"
    "cow with the crumpled horn"
    "maiden all forlorn"
    "man all tattered and torn"
    "priest all shaven and shorn"
    "rooster that crowed in the morn"
    "farmer sowing his corn"
    "horse and the hound and the horn"
)
verbs=(
    "."
    "lay in"
    "ate"
    "killed"
    "worried"
    "tossed"
    "milked"
    "kissed"
    "married"
    "woke"
    "kept"
    "belonged to"
)

main() {
    if (( ($1 < 1 || $1 > 12) || ($2 < 1 || $2 > 12))); then
        echo "invalid"
        exit 1
    fi
    for no_verses in $(seq "$1" "$2"); do
        echo -n "This is the "
        for (( verse=no_verses-1; verse>=0; --verse )); do
            noun=${nouns[$verse]}
            verb=${verbs[$verse]}
            if (( verse == 0 )); then
                echo -e "${noun}${verb}\n"
            else
                echo -ne "${noun}\nthat ${verb} the "
            fi
        done
    done
}

main "$@"