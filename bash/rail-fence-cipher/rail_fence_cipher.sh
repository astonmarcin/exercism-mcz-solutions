#!/usr/bin/env bash

encode () {
    rails="$1"
    message="$2"
    message_len=${#message}
    output=()
    rail_no=0
    rail_direction=1

    for (( idx=0; idx<message_len; idx++ )); do
        ## put the message's char into the right rail
        output[rail_no]+=${message:idx:1}
        ## select the next rail
        (( rail_no += rail_direction ))
        if (( rail_no == 0 || rail_no == rails - 1 )); then
            (( rail_direction *= -1 ))
        fi
    done

    printf "%s" "${output[@]}"
}

decode () {
    rails="$1"
    message="$2"
    message_len=${#message}
    message_splitted=()
    chars_in_rails=()
    for (( idx=0; idx<rails; idx++ )); do
        chars_in_rails+=( 0 )
    done
    rail_no=0
    rail_direction=1

    ## determine how many chars can be placed in each rails
    for (( idx=0; idx<message_len; idx++ )); do
        (( chars_in_rails[rail_no] += 1 ))
        (( rail_no += rail_direction ))
        if (( rail_no == 0 || rail_no == rails - 1 )); then
            (( rail_direction *= -1 ))
        fi
    done

    ## split encoded message into rails
    start_char_idx=0
    for chars_len in "${chars_in_rails[@]}"; do
        message_splitted+=( "${message:start_char_idx:chars_len}" )
        (( start_char_idx += chars_len ))
    done

    ## pick chars from each rails to output, with rail hop rules
    rail_no=0
    rail_direction=1
    decoded=""
    for (( idx=0; idx<message_len; idx++ )); do
        decoded+="${message_splitted[rail_no]:0:1}"
        message_splitted[rail_no]="${message_splitted[rail_no]:1}"
        (( rail_no += rail_direction ))
        if (( rail_no == 0 || rail_no == rails - 1 )); then
            (( rail_direction *= -1 ))
        fi
    done

    echo "$decoded"
}

main () {
    what_to_do="$1"
    rails="$2"
    message="$3"
    (( rails < 1 )) && { echo "rails cannot be zero or less"; exit 1; }
    case $what_to_do in 
        "-e") encode "$rails" "$message" ;;
        "-d") decode "$rails" "$message" ;;
        *) echo "only -d or -e allowed"; exit1 ;;
    esac
}

main "$@"