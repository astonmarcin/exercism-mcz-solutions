#!/bin/bash

if ! [[ "$*" =~ ^[0-9]+$ ]]; then
    echo "Usage: leap.sh <year>"
    exit 1
fi

output="false"

if (( $1 % 4 == 0 )) && (( $1 % 100 != 0 )) || (( $1 % 400 == 0 )); then
    output="true"
fi

echo "$output"
