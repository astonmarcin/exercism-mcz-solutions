#!/usr/bin/env bash

declare -a input
declare -A score_table
declare -a teams

score_table_set() {
    row=$1
    col=$2
    value=$3
    IFS=' ' read -r -a rowdata <<< "${score_table[$row]}"
    rowdata["$col"]=$((rowdata[col] + value))
    score_table["$row"]="${rowdata[*]}"
}

score_table_get() {
    row=$1
    col=$2
    IFS=' ' read -r -a rowdata <<< "${score_table[$row]}"
    echo "${rowdata[$col]}"
}

score_table_sort() {
    col=$1
    for key in "${!score_table[@]}"; do
        IFS=' ' read -r -a rowdata <<< "${score_table[$key]}"
        echo "${rowdata[$col]} \"$key\""
    done | sort -k1,1nr -k2,2 | cut -d\" -f2
}

main() {
    ## read input lines
    while read -r line; do
        input+=("$line")
    done
     
    echo "Team                           | MP |  W |  D |  L |  P"

    ## count scores and save it
    if [[ "${input[*]}" != "" ]]; then
        for game in "${input[@]}"; do
            IFS=';' read -ra splitted <<< "$game"
            [[ ! ${teams[*]} =~ .*${splitted[0]}.* ]] && teams+=("${splitted[0]}") && score_table["${splitted[0]}"]="0 0 0 0 0"
            [[ ! ${teams[*]} =~ .*${splitted[1]}.* ]] && teams+=("${splitted[1]}") && score_table["${splitted[1]}"]="0 0 0 0 0"

            ## increment Match Played
            score_table_set "${splitted[0]}" 0 1
            score_table_set "${splitted[1]}" 0 1

            ## count points
            if [[ ${splitted[2]} == "win" ]]; then
                score_table_set "${splitted[0]}" 1 1
                score_table_set "${splitted[1]}" 3 1
                score_table_set "${splitted[0]}" 4 3
            elif [[ ${splitted[2]} == "loss" ]]; then
                score_table_set "${splitted[1]}" 1 1
                score_table_set "${splitted[0]}" 3 1
                score_table_set "${splitted[1]}" 4 3
            elif [[ ${splitted[2]} == "draw" ]]; then
                score_table_set "${splitted[0]}" 2 1
                score_table_set "${splitted[1]}" 2 1
                score_table_set "${splitted[0]}" 4 1
                score_table_set "${splitted[1]}" 4 1
            fi
        done
    
        ## prepare output
        teams_sorted=$(score_table_sort 4)
        while read -r team; do
            MP=$(score_table_get "$team" 0)
            W=$(score_table_get "$team" 1)
            D=$(score_table_get "$team" 2)
            L=$(score_table_get "$team" 3)
            P=$(score_table_get "$team" 4)
            printf "%-30s | %2d | %2d | %2d | %2d | %2d\n" "$team" "$MP" "$W" "$D" "$L" "$P"
        done <<< "$teams_sorted"
    fi
}

main "$@"