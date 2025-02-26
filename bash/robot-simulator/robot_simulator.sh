#!/usr/bin/env bash

direction_matrix=(
    "north"
    "east"
    "south"
    "west"
)

main () {
    ## set the initial coordination, default to 0 if not set
    x="${1:-0}"
    y="${2:-0}"

    ## set the direction, default "north" if not set
    direction="${3:-north}"
    for i in "${!direction_matrix[@]}"; do
        if [[ $direction == "${direction_matrix[$i]}" ]]; then
            direction=$i
            break
        fi
    done
    ## error handling the direction
    [[ ! $direction =~ ^[0123]$ ]] && { echo "invalid direction"; exit 1; }

    ## set the instructions
    instructions="$4"
    ## error handling the instructions
    [[ -n $instructions && ! $instructions =~ ^[LRA]+$ ]] && { echo invalid instruction; exit 1; }

    ## read each instruction and proceed
    for (( i=0; i<${#instructions}; i++ )); do
        inst=${instructions:$i:1}
        case $inst in
            "R")
                direction=$(( ( direction + 1 ) %4 ))
                ;;
            "L")
                direction=$(( ( direction + 3 ) %4 ))
                ;;
            "A")
                case $direction in
                    0)
                        (( y += 1 ))
                        ;;
                    1)
                        (( x += 1 ))
                        ;;
                    2)
                        (( y -= 1 ))
                        ;;
                    3)
                        (( x -= 1 ))
                        ;;
                esac
                ;;
        esac
    done

    echo "$x $y ${direction_matrix[$direction]}"
}

main "$@"