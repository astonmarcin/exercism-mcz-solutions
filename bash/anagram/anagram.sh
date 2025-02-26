#!/usr/bin/env bash

main() {
   word="$1" 
   candidates="$2"
   word_lowercase=${word,,}
   word_aplhabetically=$(echo "$word_lowercase" | grep -o . | sort)
   output=""
   for candidate in $candidates; do
       candidate_lowercase=${candidate,,}
       [[ "$candidate_lowercase" == "$word_lowercase" ]] && continue
       candidate_aplhabetically=$(echo "$candidate_lowercase" | grep -o . | sort)
       [[ "$word_aplhabetically" == "$candidate_aplhabetically" ]] && output+="$candidate "
   done
   echo "${output%?}"
}

main "$@"