#!/usr/bin/env bash

declare -A CATEGORIES_MAP=(
    ["straight_flush"]=0
    ["four"]=1
    ["full"]=2
    ["flush"]=3
    ["straight"]=4
    ["three"]=5
    ["two"]=6
    ["one"]=7
    ["high"]=8
)
CARDS_ORDER="AKQJ1098765432a"
RANKS_NUMBER=${#CARDS_ORDER}

sort_cards () {
    ## sort hand with a card's power
    local input=("$@")
    for i in "${input[@]}"; do
        echo "${CARDS_ORDER%%$i*} $i"
    done | sort -n | cut -d' ' -f2- | tr '\n' ' ' | tr -d ' '
}

calc_hand_value () {
    ## calculate card's value - useful when multiple hand with same category
    in=${1//0/}
    len=${#in}
    value=0
    for (( idx=0; idx<len; idx++ )); do
        rank="${in:idx:1}"
        rank_weight=${CARDS_ORDER%%$rank*}
        rank_weight=$(( RANKS_NUMBER - ${#rank_weight} ))
        (( value += rank_weight * 10 ** (len - idx) ))
    done
    echo $value
}

main () {
    declare -a hands
    while (( $# > 0 )); do
        hands+=("$1")
        shift
    done
    declare -a hand_category    ## collecting a hand's category (indexed same way as the ${hands})
    declare -a hand_value       ## array of hand's value, needed when there's multiple hands with same category (indexed same way as the ${hands})
    
    ## iterate through every hands
    for hand_idx in "${!hands[@]}"; do
        read -r -a hand <<< "${hands[hand_idx]}"
        local -a ranks=()
        local -A ranks_counter=()
        local -A suits_counter=()

        ## iterating every cards in hand - to collect its suits and ranks
        for card in "${hand[@]}"; do
            if [[ $card =~ ^(.+)(.)$ ]]; then
                ranks_counter[${BASH_REMATCH[1]}]=$(( ranks_counter[${BASH_REMATCH[1]}] + 1 ))
                suits_counter[${BASH_REMATCH[2]}]=$(( suits_counter[${BASH_REMATCH[2]}] + 1 ))
                ranks+=( "${BASH_REMATCH[1]}" )
            fi
        done

        ## exception for lowest straight with ace - replace "A" with "a" (for right sorting)
        if [[ "$(sort_cards "${ranks[@]}")" == "A5432" ]]; then
            for idx in "${!ranks[@]}"; do
                if [[ ${ranks[idx]} == "A" ]]; then
                    ranks[idx]="a"
                fi
            done
            ranks_counter[a]=${ranks_counter[A]}
            unset "ranks_counter[A]"
        fi
        sorted_ranks=$(sort_cards "${ranks[@]}")

        ## determining a hand category
        if (( ${#suits_counter[@]} == 1 )) && [[ $CARDS_ORDER =~ $sorted_ranks ]]; then
            ## straight flush
            hand_category+=("${CATEGORIES_MAP["straight_flush"]}")
            hand_value+=("$(calc_hand_value "$sorted_ranks")")
        elif [[ ${ranks_counter[*]} =~ 4 ]]; then
            ## four of a kind
            hand_category+=("${CATEGORIES_MAP["four"]}")
            for i in "${!ranks_counter[@]}"; do
                if (( ranks_counter[$i] == 4 )); then
                    first=$i
                else
                    remain=$i
                fi
            done
            hand_value+=("$(calc_hand_value "${first}${remain}")")
        elif [[ ${ranks_counter[*]} =~ ^(2 3|3 2)$ ]]; then
            ## full house
            hand_category+=("${CATEGORIES_MAP["full"]}")
            for i in "${!ranks_counter[@]}"; do
                if (( ranks_counter[$i] == 3 )); then
                    first=$i
                else
                    remain=$i
                fi
            done
            hand_value+=("$(calc_hand_value "${first}${remain}")")
        elif [[ ${suits_counter[*]} == "5" ]]; then
            ## flush
            hand_category+=("${CATEGORIES_MAP["flush"]}")
            hand_value+=("$(calc_hand_value "$sorted_ranks")")
        elif [[ $CARDS_ORDER =~ $sorted_ranks ]]; then
            ## straight
            hand_category+=("${CATEGORIES_MAP["straight"]}")
            hand_value+=("$(calc_hand_value "$sorted_ranks")")
        elif [[ ${ranks_counter[*]} =~ 3 ]]; then
            ## three of a kind
            hand_category+=("${CATEGORIES_MAP["three"]}")
            remain=""
            for i in "${!ranks_counter[@]}"; do
                if (( ranks_counter[$i] == 3 )); then
                    first=$i
                else
                    remain+="$i "
                fi
            done
            hand_value+=("$(calc_hand_value "${first}$(sort_cards $remain)")")
        elif [[ ${ranks_counter[*]} =~ 2.+2 ]]; then
            ## two pairs
            hand_category+=("${CATEGORIES_MAP["two"]}")
            first=""
            for i in "${!ranks_counter[@]}"; do
                if (( ranks_counter[$i] == 2 )); then
                    first+="$i "
                else
                    remain=$i
                fi
            done
            hand_value+=("$(calc_hand_value "$(sort_cards $first)${remain}")")
        elif [[ ${ranks_counter[*]} =~ 2 ]]; then
            ## one pair
            hand_category+=("${CATEGORIES_MAP["one"]}")
            remain=""
            for i in "${!ranks_counter[@]}"; do
                if (( ranks_counter[$i] == 2 )); then
                    first=$i
                else
                    remain+="$i "
                fi
            done
            hand_value+=("$(calc_hand_value "${first}$(sort_cards $remain)")")
        else
            ## high card
            hand_category+=("${CATEGORIES_MAP["high"]}")
            hand_value+=("$(calc_hand_value "$sorted_ranks")")
        fi
    done
    
    ## determine the best category and possible best hands
    best_category="${hand_category[0]}"
    possible_hands=()
    for category_idx in "${!hand_category[@]}"; do
        category=${hand_category[category_idx]}
        if (( category < best_category )); then
            possible_hands=()
            best_category=${category}
            possible_hands+=("$category_idx")
        elif (( category == best_category )); then
            possible_hands+=("$category_idx")
        fi
    done
    
    ## from the possible hands - choose those with highest cards value
    highest_cards_value=0
    output=()
    for idx in "${possible_hands[@]}"; do
        cards_value=${hand_value[idx]}
        if (( cards_value > highest_cards_value )); then
            output=()
            highest_cards_value="$cards_value"
            output+=( "$idx" )
        elif (( cards_value == highest_cards_value )); then
            output+=( "$idx" )
        fi
    done

    ## print the output
    for hand in "${output[@]}"; do
        echo "${hands[hand]}"
    done
}

main "$@"