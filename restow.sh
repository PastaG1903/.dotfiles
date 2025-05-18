#!/bin/bash

list=""
for elem in $(lsd -1FX | grep /); do
	if [ "$elem" != "grub/" ] && [ "$elem" != "keyd/" ]; then
		list="$list ${elem::-1}"
	fi
done

for elem in $list; do
	stow "$elem"
done

if [ "$@" = "--remove"]; then
	sudo rm /etc/default/grub
fi

sudo stow --target=/etc/default/ grub

sudo stow --target=/etc/ keyd
