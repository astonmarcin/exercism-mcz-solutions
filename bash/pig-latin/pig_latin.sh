#!/usr/bin/env bash

set -o noglob

declare -a output

main () {
    for word in "$@"; do
        if [[ $word =~ ^(xr|yt|[aeiou]).*$ ]]; then
            output+=( "${word}ay" ) 
        elif [[ $word =~ ^([^aeiou]+)(y.*)$ ]]; then
            output+=( "${BASH_REMATCH[2]}${BASH_REMATCH[1]}ay" )
        elif [[ $word =~ ^([^aeiou]*qu)(.*)$ ]]; then
            output+=( "${BASH_REMATCH[2]}${BASH_REMATCH[1]}ay" )
        elif [[ $word =~ ^([^aeiou]*)(.*)$ ]]; then
            output+=( "${BASH_REMATCH[2]}${BASH_REMATCH[1]}ay" )
        fi
    done

    echo "${output[*]}"
}

main "$@"