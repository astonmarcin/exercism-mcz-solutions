#!/usr/bin/env bash

declare -A orbital_period
orbital_period["Mercury"]=0.2408467
orbital_period["Venus"]=0.61519726
orbital_period["Earth"]=1.0
orbital_period["Mars"]=1.8808158
orbital_period["Jupiter"]=11.862615
orbital_period["Saturn"]=29.447498
orbital_period["Uranus"]=84.016846
orbital_period["Neptune"]=164.7913

seconds_in_year=$(echo "365.25 * 24 * 60 * 60" | bc)

main() {
    planet="$1"
    age="$2"

    [[ "${orbital_period[$planet]}" == "" ]] && echo "not a planet" && exit 1

    printf "%.2f\n" "$(echo "${age} / ${seconds_in_year} / ${orbital_period[$planet]}" | bc -l)"
}

main "$@"