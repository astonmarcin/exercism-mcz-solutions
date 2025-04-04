#!/usr/bin/env bash

get_primes () {
    limit=$1
    nth=$(($2-1))
    is_primes=()
    for (( i=2; i<=limit; i++ )); do
        is_primes[i]="true"
    done

    for (( i=2; i*i<=limit; i++ )); do
        if ${is_primes[i]}; then
            (( i == 2 )) && step=2 || step=$((2*i))
            for (( j=i*i; j<=limit; j+=step )); do
                is_primes[j]=false
            done
        fi
    done

    output=()
    for (( k=2; k<=limit; k++ )); do
        ${is_primes[k]} && output+=("$k")
    done

    echo "${output[nth]}"
}

main () {
    (( $1 < 1 )) && { echo "invalid input"; exit 1; }
    
    upper=$( printf "2 + 1.2 * %d * l(%d)\n" "$1" "$1" | bc -l )
    upper="${upper%.*}"

    get_primes "$upper" "$1"
}

main "$@"