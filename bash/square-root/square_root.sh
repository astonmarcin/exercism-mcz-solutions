#!/usr/bin/env bash

main() {
    echo "sqrt($1)" | bc
}

main "$@"