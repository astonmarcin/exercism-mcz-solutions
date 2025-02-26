#!/usr/bin/env bash

throw_error() {
    echo "$1"
    exit 1
}

main () {
    rolls=( "$@" )
    roll_idx=0
    frame_idx=0
    last_roll_type=
    score=0
    while (( frame_idx < 10 )); do
        # pick a roll score
        roll_points=${rolls[$roll_idx]}
        # error handling - check if points are allowed
        (( roll_points < 0 )) && throw_error "Negative roll is invalid"
        (( roll_points > 10 )) && throw_error "Pin count exceeds pins on the lane" 
        [[ ! "$roll_points" =~ ^[0-9]+$ ]] && throw_error "Score cannot be taken until the end of the game"

        if (( roll_points == 10 )); then
            # STRIKE
            roll_points_1=${rolls[$(( roll_idx + 1 ))]}
            roll_points_2=${rolls[$(( roll_idx + 2 ))]}
            # strike error handling
            ((
                roll_points_1 > 10 || roll_points_2 > 10 ||
                (roll_points_1 < 10 && roll_points_2 < 10 && (roll_points_1 + roll_points_2) > 10) ||
                (roll_points_1 < 10 && roll_points_2 == 10)
            )) && throw_error "Pin count exceeds pins on the lane"
            [[ ! $roll_points_1 =~ ^[0-9]+$ || ! "$roll_points_2" =~ ^[0-9]+$ ]] && throw_error "Score cannot be taken until the end of the game"
            # all goot, add points to score
            (( score += roll_points + roll_points_1 + roll_points_2 ))
            last_roll_type="strike"
            (( roll_idx+=1 ))
        else
            # pick next roll, decide if spare or open frame
            (( roll_idx+=1 ))
            roll_points_1=${rolls[$roll_idx]}
            # error handling - check if points are allowed
            (( roll_points_1 > 10 )) && throw_error "Pin count exceeds pins on the lane"
            [[ ! $roll_points_1 =~ ^[0-9]+$ ]] && throw_error "Score cannot be taken until the end of the game"

            if (( roll_points + roll_points_1 == 10 )); then
                # SPARE
                roll_points_2=${rolls[$(( roll_idx + 1 ))]}
                # spare error handling
                (( roll_points_2 > 10 )) && throw_error "Pin count exceeds pins on the lane"
                [[ ! $roll_points_2 =~ ^[0-9]+$ ]] && throw_error "Score cannot be taken until the end of the game"
                # all good, add points to score
                (( score += roll_points + roll_points_1 + roll_points_2 ))
                last_roll_type="spare"
                (( roll_idx+=1 ))

            elif (( roll_points + roll_points_1 > 10 )); then
                # ERROR
                throw_error "Pin count exceeds pins on the lane"

            else
                # OPEN FRAME
                (( score += roll_points + roll_points_1 ))
                last_roll_type="open_frame"
                (( roll_idx+=1 ))
            fi

        fi
        (( frame_idx+=1 ))
    done

    # error handling - last frame was calculated, let's see if there left any rolls
    declare -A idx=( [strike]=2 [spare]=1 [open_frame]=0 )
    unallowed_roll_idx=$(( roll_idx + idx[$last_roll_type] ))
    [[ ${rolls[$unallowed_roll_idx]} =~ ^[0-9]+$ ]] && throw_error "Cannot roll after game is over"

    # everything is fine, print score
    echo $score
}

main "$@"