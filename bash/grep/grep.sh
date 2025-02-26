#!/usr/bin/env bash

main() {
    local _line_number=false
    local _only_filenames=false
    local _case_insensitive=false
    local _reverse_match=false
    local _entire_line=false
    declare -a files

    ## handle arguments
    while :; do
        case $1 in
            -n)
                _line_number=true ;;
            -l)
                _only_filenames=true ;;
            -i)
                _case_insensitive=true ;;
            -v)
                _reverse_match=true ;;
            -x)
                _entire_line=true ;;
            *)
                break ;;
        esac
        shift
    done
    $_case_insensitive && pattern=${1,,} || pattern=${1}
    $_entire_line && pattern="^${pattern}$"
    shift
    while (( $# > 0 )); do
        files+=("$1")
        shift
    done

    for file in "${files[@]}"; do
        line_counter=0
        while read -r line; do
            (( line_counter+=1 ))
            $_case_insensitive && line_to_match=${line,,} || line_to_match=${line}

            ## check if line match
            if $_reverse_match; then
                [[ ! ${line_to_match} =~ $pattern ]] && matched_line=$line || continue
            else 
                [[ ${line_to_match} =~ $pattern ]] && matched_line=$line || continue
            fi

            ## prepare output
            $_only_filenames && echo "${file}" && break
            $_line_number && matched_line=${line_counter}:${matched_line}
            (( ${#files[@]} > 1 )) && echo "${file}:${matched_line}" && continue
            echo "$matched_line"
        done < "$file"
    done
}

main "$@"