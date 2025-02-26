#!/usr/bin/env bash

main() {
    phone_number=${1//[!0-9]/}
    if [[ ${phone_number:0:1} -eq 1 ]]; then
        phone_number=${phone_number:1}
    fi
    if [[ ${phone_number:0:1} =~ [2-9] && ${phone_number:3:1} =~ [2-9] && ${#phone_number} -eq 10 ]]; then
        echo "$phone_number"
    else
        echo "Invalid number.  [1]NXX-NXX-XXXX N=2-9, X=0-9"
        exit 1
    fi
}

main "$@"