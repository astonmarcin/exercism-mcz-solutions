#!/usr/bin/env bash

declare -A plants_matrix
plants_matrix+=(
    ["R"]="radishes"
    ["C"]="clover"
    ["G"]="grass"
    ["V"]="violets"
)

students=(
    "Alice"
    "Bob"
    "Charlie"
    "David"
    "Eve"
    "Fred"
    "Ginny"
    "Harriet"
    "Ileana"
    "Joseph"
    "Kincaid"
    "Larry"
)

main () {
    IFS=$'\n' read -rd '' -a garden <<< "$1"
    student="$2"
    
    ## get index of student
    for i in "${!students[@]}"; do
        [[ ${students[$i]} == "$student" ]] && { student_id=$i; break; }
    done
    
    ## extract plants
    plants=
    for line in "${garden[@]}"; do
        plants+="${plants_matrix[${line:$(( 2 * student_id )):1}]} " 
        plants+="${plants_matrix[${line:$(( 2 * student_id + 1 )):1}]} " 
    done
    
    ## write out plants names
    echo "${plants% }"
}

main "$@"