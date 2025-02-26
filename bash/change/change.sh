#!/usr/bin/env bash

main () {
    target="$1"; shift
    IFS=" " read -r -a coins <<< "$@"
    
    ## error handling
    (( target < 0 )) && { echo "target can't be negative"; exit 1; }
    (( target == 0 )) && { echo; exit 0;}
    
    ## declaring initial vars and arrays
    max_integer=9223372036854775805
    min_coins=()
    coin_used=()
    for (( idx=0; idx<=target+1; idx++ )); do
        min_coins+=( "$max_integer" )
        coin_used+=( -1 )
    done
    min_coins[0]=0

    for (( idx=1; idx<=target; idx++ )); do
        for coin in "${coins[@]}"; do
            if (( coin <= target )); then
                if (( 1 + min_coins[idx - coin] < min_coins[idx] )); then
                    (( min_coins[idx] = 1 + min_coins[idx - coin] ))
                    (( coin_used[idx] = coin ))
                fi
            fi
        done
    done

    (( min_coins[target] == max_integer )) && { echo "can't make target with given coins"; exit 1; }

    output=()
    while (( target > 0 )); do
        output+=( "${coin_used[$target]}" )
        (( target -= coin_used[target] ))
    done

    echo "${output[*]}"
}

main "$@"