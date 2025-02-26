#!/usr/bin/env bash

animals=(
    "fly"
    "spider"
    "bird"
    "cat"
    "dog"
    "goat"
    "cow"
    "horse"
)

animal_second_verse=(
    "I don't know why she swallowed the fly. Perhaps she'll die."
    "It wriggled and jiggled and tickled inside her."
    "How absurd to swallow a bird!"
    "Imagine that, to swallow a cat!"
    "What a hog, to swallow a dog!"
    "Just opened her throat and swallowed a goat!"
    "I don't know how she swallowed a cow!"
    "She's dead, of course!"
)

main () {
    (( $# != 2 )) && { echo "2 arguments expected"; exit 1; }
    (( $1 > $2 )) && { echo "Start must be less than or equal to End"; exit 1; }

    declare -a output

    for (( idx=$1-1; idx<$2; idx++ )); do
        animal=${animals[idx]}
        output+=( "I know an old lady who swallowed a ${animal}." )
        output+=( "${animal_second_verse[idx]}" )
        [[ $animal == "horse" ]] && break
        for (( verse=idx; verse>0; verse-- )); do
            second_animal=${animals[verse-1]}
            [[ $second_animal == "spider" ]] && second_animal_txt="${second_animal} that wriggled and jiggled and tickled inside her" || second_animal_txt="${second_animal}"
            output+=( "She swallowed the ${animals[verse]} to catch the ${second_animal_txt}." )
            [[ $second_animal == "fly" ]] && output+=( "${animal_second_verse[0]}" )
        done
        output+=( "" )
    done

    printf "%s\n" "${output[@]}"
}

main "$@"