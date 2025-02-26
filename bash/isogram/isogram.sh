#!/usr/bin/env bash

main() {
    word=$1
    
    ## convert to lowercase
    word=${word,,}

    ## rid out non-alphabet chars
    word_sorted=$(echo "$word" | grep -o . | sort)
    word_sorted=${word_sorted//[!a-z]/}

    for (( char=0; char<${#word_sorted}-1; char++ )); do
        char_next=$((char+1))
        if [[ "${word_sorted:$char:1}" == "${word_sorted:$char_next:1}" ]]; then
            echo false
            exit 0
        fi
    done
    echo true
}

main "$@"



## python way:
## from string import ascii_lowercase
## def is_isogram(string)
##     all(string.lower().count(letter) <= 1 for letter in ascii_lowercase)

###   all(
###       for letter in ascii_lowercase:
###           if string.lower().count(letter) <= 1:
###               return True
###           return False
###               
###   )