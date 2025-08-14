#!/bin/bash

list=""
for elem in $(lsd -1FX | grep /); do
	if [ "$elem" != "grub/" ] && [ "$elem" != "keyd/" ] && [ "$elem" != "thinkfan/" ]; then
		list="$list ${elem::-1}"
	fi
done

for elem in $list; do
	stow "$elem"
done

if [ "$@" = "-nohome" ]; then
	sudo cp ./grub/grub /etc/default/grub
	sudo stow --target=/etc/ keyd
	sudo cp ./thinkfan/thinkfan.hook /usr/lib/systemd/system-sleep/thinkfan
	sudo cp ./thinkfan/thinkfan.yaml /etc/thinkfan.yaml
fi

