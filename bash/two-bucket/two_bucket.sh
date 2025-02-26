#!/usr/bin/env bash

fill () {
    idx=$1; shift
    _buckets=( "$@" )
    _buckets[idx]=${sizes[idx]}
    echo "${_buckets[@]}"
}

empty () {
    idx=$1; shift
    _buckets=( "$@" )
    _buckets[idx]=0
    echo "${_buckets[@]}"
}

from_bucket_to_bucket () {
    idx="$1"; shift
    _buckets=( "$@" )
    alt_idx=$(( idx ^ 1 ))

    min1=$(( sizes[idx] - _buckets[idx] ))
    min2=$(( _buckets[alt_idx] ))
    (( min1 < min2 )) && amount=$min1 || amount=$min2

    (( _buckets[idx] += amount ))
    (( _buckets[alt_idx] -= amount ))

    echo "${_buckets[@]}"
}


main () {
    sizes=( "$1" "$2" )
    goal="$3"
    goal_idx=
    case $4 in
        "one") goal_idx=0 ;;
        "two") goal_idx=1 ;;
        *) exit 1 ;;
    esac

    buckets=( 0 0 )
    invalid=()
    for (( i=0; i<=1; i++ )); do
        invalid[i]=$(( i == goal_idx ? 0 : sizes[i] ))
    done
    
    ## first step - a starting bucket need to be filled
    read -r -a buckets <<< "$(fill $goal_idx "${buckets[@]}")"
    count=1
    counters=()

    to_check=()
    checked=

    ## enter the loop, until one of bucket has a goal amount in it
    while (( goal != buckets[0] && goal != buckets[1] )); do
        if [[ "${buckets[*]}" != "${invalid[*]}" ]] && ! [[ "${checked[*]}" =~ ,:${buckets[*]}:, ]]; then
            ## save the current bucket state, to not valuating it next time
            checked+=",:${buckets[*]}:,"
            ## increase step counter
            (( cnt = count + 1 ))

            ## generate possible next moves
            for (( i=0; i<=1; i++ )); do
                if (( buckets[i] != 0 )); then
                    ## state 1) i-th bucket isn't empty, empty it
                    for word in $(empty $i "${buckets[@]}"); do to_check+=( "$word" ); done
                    counters+=( "$cnt" )
                fi
                if (( buckets[i] != sizes[i] )); then
                    ## state 2) i-th bucket isn't full; fill it to max
                    for word in $(fill $i "${buckets[@]}"); do to_check+=( "$word" ); done
                    counters+=( "$cnt" )
                    ## state 3) pour the water from i-th bucket to other
                    for word in $(from_bucket_to_bucket $i "${buckets[@]}"); do to_check+=( "$word" ); done
                    counters+=( "$cnt" )
                fi
            done
        fi

        ## error handling - no more possible buckets states, exit with error
        (( ${#to_check} == 0 )) && { echo "invalid goal"; exit 1; }
        
        ## pick next buckets state to validate...    ... and pop it from 'to_check' array
        read -r -a buckets <<< "${to_check[*]:0:2}"; read -r -a to_check <<< "${to_check[*]:2}"
        ## pick the corresponding bucket state step counter
        count=${counters[0]}; read -r -a counters <<< "${counters[*]:1}"
    done

    ## get the output values
    for (( i=0; i<=1; i++ )); do
        (( buckets[i] == goal )) && goal_bucket_idx=$i
    done
    (( goal_bucket_idx == 0 )) && goal_bucket="one" || goal_bucket="two"
    other_bucket_idx=$(( goal_bucket_idx ^ 1 ))
    
    ## and print them!
    echo "moves: ${count}, goalBucket: ${goal_bucket}, otherBucket: ${buckets[other_bucket_idx]}"
}

main "$@"