#!/usr/bin/env bash

declare -A days_matrix=(
    [Monday]=1
    [Tuesday]=2
    [Wednesday]=3
    [Thursday]=4
    [Friday]=5
    [Saturday]=6
    [Sunday]=7
)
declare -A weeks_matrix=(
    [first]=0
    [second]=1
    [third]=2
    [fourth]=3
    [last]=-1
    [teenth]=4
)

main () {
    year="$1"
    month=$(printf "%02d" "$2")
    [[ ${!weeks_matrix[*]} =~ $3 ]] || { echo "the week is not valid, need to be one of '${!weeks_matrix[*]}'"; exit 1; }
    [[ ${!days_matrix[*]} =~ $4 ]] || { echo "the day of week is not valid, need to be one of '${!days_matrix[*]}'"; exit 1; }
    week=${weeks_matrix[$3]}
    day_of_week=${days_matrix[$4]}

    ## offset from the 1st month's day to the first day of a week
    days_to_add=$(( (7 + day_of_week - $(date -d "$year-$month-01" +%u)) % 7 ))

    ## collect dates which are looking for day of a week
    all_days_of_week=()
    for (( i=0; i<=(week == -1 ? 4 : week); i++ )); do
        all_days_of_week+=( "$(date -d "$year-$month-01 +$(( "$days_to_add" + 7 * i )) days" +%Y-%m-%d)" )
    done
    ## the last date can be from next month, if so - delete it
    [[ ${all_days_of_week[-1]:5:2} != "$month" ]] && unset 'all_days_of_week[-1]'
    
    ## print the output
    case $week in 
        4) 
            for idx in 1 2; do
                day=${all_days_of_week[idx]}
                _day=$(date -d "$day" +%_d)
                (( 13 <= _day && _day <= 19 )) && { echo "$day"; break; }
            done
            ;;
        *) 
            echo "${all_days_of_week[week]}"
            ;;
    esac
}

main "$@"