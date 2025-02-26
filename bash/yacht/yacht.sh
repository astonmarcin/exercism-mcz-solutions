#!/usr/bin/env bash

cat_singles () {
    echo $(( dices_map[$1] * $1 ))
}

cat_full_house () {
    if [[ ${dices_map[*]} =~ (2.*3)|(3.*2) ]]; then
        cat_choice
    else
        echo 0
    fi
}

cat_four_of_a_kind () {
    has_solution=false
    for dice in "${!dices_map[@]}"; do
        if (( dices_map[dice] >= 4 )); then
            echo $(( dice * 4 ))
            has_solution=true
        fi
    done
    if ! $has_solution; then
        echo 0
    fi
}

cat_straight () {
    straight_kind="$1"; shift
    case $straight_kind in
        "little")
            [[ "${dices_map[*]:1:5}" == "1 1 1 1 1" ]] && echo 30 || echo 0 ;;
        "big")
            [[ "${dices_map[*]:2:5}" == "1 1 1 1 1" ]] && echo 30 || echo 0 ;;
    esac
}

cat_choice () {
    sum=0
    for dice in "${dices[@]}"; do
        (( sum += dice ))
    done
    echo $sum
}

cat_yacht () {
    has_solution=false
    for dice in "${dices_map[@]}"; do
        ((  dice == 5 )) && has_solution=true
    done
    $has_solution && echo 50 || echo 0
}


main () {
    category="$1"; shift
    dices=( "$@" )
    dices_map=( 0 0 0 0 0 0 0 )
    for dice in "${dices[@]}"; do
        (( dices_map[dice] += 1 ))
    done
    case $category in
        "ones") 
            cat_singles 1 ;;
        "twos") 
            cat_singles 2 ;;
        "threes") 
            cat_singles 3 ;;
        "fours")
            cat_singles 4 ;;
        "fives") 
            cat_singles 5 ;;
        "sixes") 
            cat_singles 6 ;;
        "full house") 
            cat_full_house ;;
        "four of a kind") 
            cat_four_of_a_kind ;;
        "little straight") 
            cat_straight little ;;
        "big straight") 
            cat_straight big ;;
        "choice") 
            cat_choice ;;
        "yacht") 
            cat_yacht ;;
    esac
}

main "$@"