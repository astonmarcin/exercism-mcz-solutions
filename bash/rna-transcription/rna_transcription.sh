#!/usr/bin/env bash
translate() {
    case $1 in
        G)
            echo C
            ;;
        C)
            echo G
            ;;
        T)
            echo A
            ;;
        A)
            echo U
            ;;
        *)
            exit 1
            ;;
    esac
}

main() {
    rna=${1}
    output=""
    for (( char_num=0; char_num<${#rna}; char_num++ )); do
        char=${rna:$char_num:1}
        if [[ ! $char =~ [GCTA] ]]; then
            echo "Invalid nucleotide detected."
            exit 1
        fi
        output+=$(translate "$char")
    done
    echo "$output"
}

main "$@"