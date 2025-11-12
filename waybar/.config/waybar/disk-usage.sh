#!/usr/bin/bash

while [[ True ]]; do
    
root=$(lsblk -o FSUSE%,MOUNTPOINT | grep /$ | awk '{print $1}')
home=$(lsblk -o FSUSE%,MOUNTPOINT | grep home$ | awk '{print $1}')
mem=$(fastfetch | grep Memory | awk '{print $7}' | sed 's/(//' | sed 's/)//')
swap=$(fastfetch | grep Swap | awk '{print $7}' | sed 's/(//' | sed 's/)//')

rootused=$(fastfetch | grep \(/\) | awk '{print $3$4}' | sed 's/(//' | sed 's/)//')
homeused=$(fastfetch | grep home | awk '{print $3$4}' | sed 's/(//' | sed 's/)//')
memused=$(fastfetch | grep Memory | awk '{print $2$3}' | sed 's/(//' | sed 's/)//')
swapused=$(fastfetch | grep Swap | awk '{print $2$3}' | sed 's/(//' | sed 's/)//')

roottotal=$(fastfetch | grep \(/\) | awk '{print $6$7}' | sed 's/(//' | sed 's/)//')
hometotal=$(fastfetch | grep home | awk '{print $6$7}' | sed 's/(//' | sed 's/)//')
memtotal=$(fastfetch | grep Memory | awk '{print $5$6}' | sed 's/(//' | sed 's/)//')
swaptotal=$(fastfetch | grep Swap | awk '{print $5$6}' | sed 's/(//' | sed 's/)//')

echo "{\"text\": \"󱃮 at $root  ||  󰋜 at $home  ||  󰘘 at $mem  ||  󰯍 at $swap\",\"tooltip\":\"󱃮: $rootused out of $roottotal\n󰋜: $homeused out of $hometotal\n󰘘: $memused out of $memtotal\n󰯍: $swapused out of $swaptotal\"}"

sleep 2

done
