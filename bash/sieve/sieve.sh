#!/usr/bin/env bash

main () {
    ## prepare data - all possible solution which will be unset
    output=( $(seq 2 $1) )
    (( len_output = ${#output[@]} ))
    (( output_elem_idx = 0 ))
    ## iterate through array as long as we get to number from input
    while (( ( value = output[output_elem_idx] ) && value * value <= $1 )); do
        for (( idx = output_elem_idx + 1; idx < len_output; ++idx )); do
            ## drop non primary number
            if (( output[idx] % value == 0 )); then
                unset output[idx]
            fi
        done
        output=( ${output[*]} )
        (( output_elem_idx++ ))
    done
    ## print whats left in array
    echo ${output[*]}
    
}

main "$@"