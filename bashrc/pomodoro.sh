#!/bin/bash

while true; do
    notify-send -t 20000 -A Start=Start "Aight, to start working, press Start." | read input
    cycles=$(($1-1))
    for cycles in $(eval echo "{1...$cycles}"); do
        sleep $((25*60))
        notify-send -t 15000 "Time for a break."
        sleep $((5*60))
        notify-send -t 20000 -A Continue=Continue "Break time is up! Let's continue with the next pomodoro." | read input
    done
    sleep $((25*60))
    notify-send -t 20000 "Good! Let's take a longer break this time."
    sleep $(($cycles*5*60))
    notify-send -t 20000 -A Restart=Restart -A Stop=Stop "Break is over! If you want to keep working, press Restart. Otherwise, press Stop." | read input
    if [ "$input" = "Stop" ]; then
        break
    fi
done
