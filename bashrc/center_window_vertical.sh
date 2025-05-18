#!/bin/bash
IFS='x' read screenWidth screenHeight < <(xdpyinfo | grep dimensions | grep -o '[0-9x]*' | head -n1)
width=$(xdotool getactivewindow getwindowgeometry --shell | head -4 | tail -1 | sed 's/[^0-9]*//')
height=$(xdotool getactivewindow getwindowgeometry --shell | head -5 | tail -1 | sed 's/[^0-9]*//')
currentX=$(xdotool getactivewindow getwindowgeometry --shell | grep "X=" | sed 's/[^0-9]*//')
newPosY=$((screenHeight / 2 - height / 2 - 20))
xdotool getactivewindow windowmove "$currentX" "$newPosY"
