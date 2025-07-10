#!/bin/bash

while true; do
    notify-send -A Start=Start -A Cancel=Cancel "Aight, to start, press Start. Press Cancel if it isn't time to work yet." | read input
    if [ "$input" = "Cancel" ]; then
        break
    fi
    cycles=$(($1-1))
    for cycles in $(eval echo "{1...$cycles}"); do
        sleep $(($2*60))
        notify-send -t 15000 "Time for a break."
        sleep $(($3*60))
        notify-send -A Continue=Continue "Break time is up! Let's continue with the next pomodoro." | read input
    done
    sleep $(($2*60))
    notify-send "Good! Let's take a longer break this time."
    sleep $(($cycles*5*60))
    notify-send -A Restart=Restart -A Stop=Stop "Break is over! If you want to keep working, press Restart. Otherwise, press Stop." | read input
    if [ "$input" = "Stop" ]; then
        break
    fi
done
