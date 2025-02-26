#!/usr/bin/env bash

declare -A resistor_colors=(
    [black]=0
    [brown]=1
    [red]=2
    [orange]=3
    [yellow]=4
    [green]=5
    [blue]=6
    [violet]=7
    [grey]=8
    [white]=9
)

main () {
    case $1 in
        "code")
            echo "${resistor_colors[$2]}"
            ;;
        "colors")
            declare -A reversed_resistor_colors
            for key in "${!resistor_colors[@]}"; do
                value="${resistor_colors[$key]}"
                reversed_resistor_colors[$value]="$key"
            done
            for (( i=0; i<${#reversed_resistor_colors[@]}; i++ )); do 
                echo "${reversed_resistor_colors[$i]}"
            done
            ;;
    esac
}

main "$@"