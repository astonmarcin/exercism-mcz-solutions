#!/usr/bin/env bash

main () {
    declare -a input
    while IFS=$'\n' read -r line; do
        input+=("$line")
    done
    
    declare -a corners
    for (( line_idx=0; line_idx<${#input[@]}; line_idx++)); do
        line=${input[line_idx]}
        for (( char_idx=0; char_idx<${#line}; char_idx++)); do
            char=${line:char_idx:1}
            [[ $char == "+" ]] && corners+=("$line_idx $char_idx")
        done
    done
    
    output=0

    ## let's iterate through every corners
    for (( first_corner_idx=0; first_corner_idx<${#corners[@]}; first_corner_idx++ )); do
        IFS=" " read -r -a first_corner <<< "${corners[first_corner_idx]}"
        
        ## collect other corners sharing the same row and col
        local same_row=(); local same_col=()
        for (( corner_idx=first_corner_idx; corner_idx<${#corners[@]}; corner_idx++ )); do
            IFS=" " read -r -a corner <<< "${corners[corner_idx]}"
            if (( corner_idx != first_corner_idx )) && [[ "${corner[0]}" == "${first_corner[0]}" ]]; then
                same_row+=( "$corner_idx" )
            fi
            if (( corner_idx != first_corner_idx )) && [[ "${corner[1]}" == "${first_corner[1]}" ]]; then
                same_col+=( "$corner_idx" )
            fi
        done

        ## if there no other corners in row and col - it is not a rectangle
        if (( ${#same_row[@]} != 0 && ${#same_col[@]} != 0 )); then
            ## iterate through every possible combinations of second and third corners
            for second_corner_idx in "${same_row[@]}"; do
                for third_corner_idx in "${same_col[@]}"; do
                    IFS=" " read -r -a second_corner <<< "${corners[second_corner_idx]}"
                    IFS=" " read -r -a third_corner <<< "${corners[third_corner_idx]}"
                    
                    for (( corner_idx=third_corner; corner_idx<${#corners[@]}; corner_idx++ )); do
                        ## let's find out if there is fourth corner
                        fourth_corner_idx=${corner_idx}
                        IFS=" " read -r -a fourth_corner <<< "${corners[fourth_corner_idx]}"
                        if ! [[ ${third_corner[0]} == "${fourth_corner[0]}" && ${second_corner[1]} == "${fourth_corner[1]}" ]]; then
                            continue
                        fi

                        ## now, this is last check - is the sides are valid?
                        top_row_idx=${first_corner[0]}
                        bottom_row_idx=${third_corner[0]}
                        left_col_idx=${first_corner[1]}
                        right_col_idx=${second_corner[1]}

                        discard_rectangle=0
                        for (( row_idx=top_row_idx; row_idx<=bottom_row_idx; row_idx++ )); do
                            line=${input[row_idx]}
                            if (( row_idx == top_row_idx || row_idx == bottom_row_idx )); then
                                ## the top and bottom side can be only '+' or '-'
                                for (( col_idx=left_col_idx+1; col_idx<right_col_idx; col_idx++ ));do
                                    if ! [[ ${line:col_idx:1} =~ ^[+-]$ ]]; then
                                        discard_rectangle=1
                                        continue
                                    fi
                                done
                            else
                                ## the left and right side can be only '+' or '|'
                                if ! [[ ${line:left_col_idx:1} =~ ^[+|]$ && ${line:right_col_idx:1} =~ ^[+|]$ ]]; then
                                    discard_rectangle=1
                                    continue
                                fi
                            fi
                        done
                        (( discard_rectangle == 0 )) && (( output+=1 ))
                    done
                done
            done
        fi
    done

    echo $output
}

main "$@"