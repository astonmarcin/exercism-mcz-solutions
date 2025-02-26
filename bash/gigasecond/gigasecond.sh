#!/usr/bin/env bash

main () {
    TZ="UTC" date '+%Y-%m-%dT%H:%M:%S' -d @"$(( $(TZ=UTC date -d "$1" +%s) + 1000000000 ))"
}

main "$@"