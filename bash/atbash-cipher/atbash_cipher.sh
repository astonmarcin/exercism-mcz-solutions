#!/usr/bin/env bash

## generate atbash key
declare -A key
alphabet="abcdefghijklmnopqrstuvwxyz"
for (( i=0; i<26; i++ )); do
    key[${alphabet:$i:1}]=${alphabet:$((25-i)):1}
    key[$i]=$i
done

encode() {
    text=${1//[[:punct:]]/}   ## erase punctuation
    text=${text// /}          ## erase space
    text=${text,,}            ## make lowercase
    code=""
    for (( idx=0; idx<${#text}; idx++ )); do
        code+=${key[${text:$idx:1}]}
        (( (idx % 5) - 4 == 0 )) && code+=" "
    done
    echo $code
}

decode() {
    code=${1// /}
    for (( idx=0; idx<${#code}; idx++ )); do
        echo -n ${key[${code:$idx:1}]}
    done
}

main() {
    case $1 in
        encode)
            shift; encode "$@" ;;
        decode)
            shift; decode "$@" ;;
        *)
            exit 1 ;;
    esac
}

main "$@"