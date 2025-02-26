#!/usr/bin/env bash

days=(
    "first"    
    "second"
    "third"
    "fourth"
    "fifth"
    "sixth"
    "seventh"
    "eighth"
    "ninth"
    "tenth"
    "eleventh"
    "twelfth"
)        
presents=(
    "a Partridge in a Pear Tree."
    "two Turtle Doves, "
    "three French Hens, "
    "four Calling Birds, "
    "five Gold Rings, "
    "six Geese-a-Laying, "
    "seven Swans-a-Swimming, "
    "eight Maids-a-Milking, "
    "nine Ladies Dancing, "
    "ten Lords-a-Leaping, "
    "eleven Pipers Piping, "
    "twelve Drummers Drumming, "
)

main() {
    start=$(( $1 - 1))
    end=$(( $2 - 1))
    output=""
    for (( day=start; day<=end; day++ )); do
        output+="On the ${days[$day]} day of Christmas my true love gave to me: "
        for (( present=day; present>=0; present-- )); do
            if (( present == 0 && day != 0)); then
                output+="and ${presents[$present]}"
            else
                output+=${presents[$present]}
            fi
        done
        output+="\n"
    done
    echo -e "$output"
}

main "$@"