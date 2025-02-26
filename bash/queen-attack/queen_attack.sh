#!/usr/bin/env bash

main() {
    ## assigning vars
    (( $# != 4 )) && exit 1
    while (( $# != 0)); do
        case $1 in
            "-w") 
                IFS=',' read -ra white <<< "$2"
                #white="$2"
                shift 2
                ;;
            "-b")
                IFS=',' read -ra black <<< "$2"
                #black="$2"
                shift 2
                ;;
        esac
    done

    ## error handling
    if (( white[0] < 0 || black[0] < 0 ));  then
        echo "row not positive"
        exit 1
    elif (( white[1] < 0 || black[1] < 0 )); then
        echo "column not positive"
        exit 1
    elif (( white[0] > 7 || black[0] > 7 )); then
        echo "row not on board"
        exit 1
    elif (( white[1] > 7 || black[1] > 7 )); then
        echo "column not on board"
        exit 1
    elif (( white[0] == black[0] && white[1] == black[1] )); then
        echo "same position"
        exit 1
    fi

    ## let's compare positions
    if (( white[0] == black[0] || white[1] == black[1] )); then
        echo true
        exit 0
    elif (( white[0] - white[1] == black[0] - black[1] || white[0] + white[1] == black[0] + black[1] )); then
        echo true
        exit 0
    fi
    echo false
}

main "$@"