#!/usr/bin/env bash

reduce () {
    calc_gcd () {
        local a b
        a=$(abs $1)
        b=$(abs $2)
        if (( a % b == 0 )); then
            echo "$b"
        else 
            calc_gcd "$b" $(( a % b ))
        fi
    }
    gcd=$(calc_gcd "$1" "$2")
    a=$(( $1 / gcd ))
    b=$(( $2 / gcd ))
    if (( b < 0 && a >= 0 )); then
        echo "-${a}/$(abs $b)"
    elif (( b < 0 && a < 0 )); then
        echo "$(abs $a)/$(abs $b)"
    else
        echo "${a}/${b}"
    fi
}

abs () {
    echo "${1//-/}"
}

main () {
    operation="$1"
    no_1="$2"
    IFS="/" read -r -a no_1_array <<< "$2"
    no_2="$3"
    IFS="/" read -r -a no_2_array <<< "$3"
    case "$operation" in
        "+") 
            a=$(( no_1_array[0] * no_2_array[1] + no_2_array[0] * no_1_array[1]))
            b=$((no_1_array[1] * no_2_array[1]))
            ;;
        "-")
            a=$(( no_1_array[0] * no_2_array[1] - no_2_array[0] * no_1_array[1]))
            b=$(( no_1_array[1] * no_2_array[1] ))
            ;;
        "*")
            a=$(( no_1_array[0] * no_2_array[0] ))
            b=$(( no_1_array[1] * no_2_array[1] ))
            ;;
        "/")
            a=$(( no_1_array[0] * no_2_array[1] ))
            b=$(( no_1_array[1] * no_2_array[0] ))
            ;;
        "abs")
            a=$(abs "${no_1_array[0]}")
            b=$(abs "${no_1_array[1]}")
            ;;
        "pow")
            pow="$no_2"
            if (( pow >= 0 )); then
                a=$(( no_1_array[0] ** pow))
                b=$(( no_1_array[1] ** pow))
            else
                pow=$(abs $pow)
                a=$(( no_1_array[1] ** pow))
                b=$(( no_1_array[0] ** pow))
            fi
            ;;
        "rpow")
            x=${no_1}
            a=${no_2_array[0]}
            b=${no_2_array[1]}
            result=$(awk -v x=${x} -v a=${a} -v b=${b} 'BEGIN {
                nth_root = exp(log(x^a) / b);
                printf "%.6f\n", nth_root;
            }')
            echo "${result/00000}"
            exit 0
            ;;
        "reduce")
            a="${no_1_array[0]}"
            b="${no_1_array[1]}"
            ;;
        *) 
            exit 1
            ;;
    esac
    reduce "$a" "$b"
}

main "$@"