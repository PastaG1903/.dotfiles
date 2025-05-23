#!/bin/bash
IFS='x' read screenWidth screenHeight < <(xdpyinfo | grep dimensions | grep -o '[0-9x]*' | head -n1)
width=$(xdotool getactivewindow getwindowgeometry --shell | head -4 | tail -1 | sed 's/[^0-9]*//')
height=$(xdotool getactivewindow getwindowgeometry --shell | head -5 | tail -1 | sed 's/[^0-9]*//')
newPosX=$((screenWidth / 2 - width / 2))
currentY=$(xdotool getactivewindow getwindowgeometry --shell | grep "Y=" | sed 's/[^0-9]*//')
xdotool getactivewindow windowmove "$newPosX" "$currentY"
