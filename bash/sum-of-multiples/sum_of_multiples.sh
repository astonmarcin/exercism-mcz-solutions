#!/usr/bin/env bash

main() {
    level=$1; shift
    magical_items="$*"
    declare -A multipliers
    for item in $magical_items; do
        number=$item
        (( number == 0 )) && multipliers[$number]=1 && continue
        while (( number < level )); do
            multipliers[$number]=1
            number=$(( number + item ))
        done
    done
    output=0
    for multiply in "${!multipliers[@]}"; do
        output=$(( output + multiply))
    done
    echo $output
}

main "$@"