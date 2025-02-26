#!/usr/bin/env bash

main () {
    ascii_offset=65
    letter="$1"
    letter_idx=$(printf "%d" "'${letter}")
    output_size=$(( (letter_idx - ascii_offset + 1) * 2 - 1 ))
    output_middle=$(( ( output_size + 1 ) / 2 ))

    ## start with letter 'A', its ascii code is 65
    letter_ascii_code=${ascii_offset}
    for (( idx=0; idx<output_size; idx++ )); do
        ## get the letter based on ascii code
        letter_line=$(printf "%b" "$(printf '\\%03o' ${letter_ascii_code})")
        ## produce output line, first half
           ## first - print spaces to the left...
        out_line=$(for i in $(seq 1 $(( output_middle + ascii_offset - 1 - letter_ascii_code ))); do echo -n " "; done)
           ## ...letter itself...
        out_line+=${letter_line}
           ## ...and remaining spaces to the right
        out_line+=$(for i in $(seq 1 $(( letter_ascii_code - ascii_offset ))); do echo -n " "; done)
        ## now produce the second half - append chars in reversed order of first half
        for (( i=${#out_line}-2; i>=0; i-- )); do
            out_line+="${out_line:$i:1}"
        done
        
        ## print generated line
        echo "$out_line"

        ## increase or decrease a ascii codes, depends on iteration step
        if (( idx < letter_idx - ascii_offset )); then
            (( letter_ascii_code += 1 ))
        else
            (( letter_ascii_code -= 1 ))
        fi
    done
}

main "$@"