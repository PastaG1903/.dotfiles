#!/bin/bash

current_position=$(hyprctl cursorpos | awk '{print $1, $2}' | tr -d ',')
current_x=$(echo $current_position | cut -d' ' -f1)
current_y=$(echo $current_position | cut -d' ' -f2)

new_x=$((current_x + 0))
new_y=$((current_y - 10))

hyprctl dispatch movecursor $new_x $new_y
