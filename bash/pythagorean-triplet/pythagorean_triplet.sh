#!/usr/bin/env bash

gcd() (
    (( $1 % $2 == 0 )) && echo "$2" || gcd "$2" $(( $1 % $2 ))
)

main () {
    number="$1"

    output=()
    for (( m=1; m<=$(echo "sqrt($number) + 1" | bc); m++ )); do
        for (( n=1; n<=m; n++ )); do
            if (( $(gcd $m $n) == 1 && (m-n) % 2 == 1 )); then
                k=1
                a=$(( m**2 - n**2 ))
                b=$(( 2 * m * n ))
                c=$(( m**2 + n**2 ))
                while (( k * c < number )); do
                    if (( k * (a + b + c) == number )); then
                        output+=( "$(echo -ne "$((k*a))\n$((k*b))\n$((k*c))" | sort -n | tr '\n' ',' | head -c -1)" )
                    fi
                    (( k += 1 ))
                done
            fi
        done
    done

    for solution in "${output[@]}"; do
        echo "$solution"
    done
}

main "$@"