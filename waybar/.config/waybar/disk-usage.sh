#!/usr/bin/bash

root=$(df | grep /$ | awk '{print $5}')
home=$(df | grep home$ | awk '{print $5}')

echo "󱃮 at $root || 󰋜 at $home"
