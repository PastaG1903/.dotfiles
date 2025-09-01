#!/bin/bash

list=""
for elem in $(lsd -1FX | grep /); do
	if [ "$elem" != "grub/" ] && [ "$elem" != "keyd/" ] && [ "$elem" != "thinkfan/" ] && [ "$elem" != "tlp/" ] && [ "$elem" != "pacman/" ]; then
		list="$list ${elem::-1}"
	fi
done

for elem in $list; do
	stow "$elem"
done

if [ "$@" = "-nohome" ]; then
	sudo stow --target=/etc/default/ grub
	sudo stow --target=/etc/ keyd
	sudo cp ./thinkfan/thinkfan.hook /usr/lib/systemd/system-sleep/thinkfan
	sudo cp ./thinkfan/thinkfan.yaml /etc/thinkfan.yaml
	sudo cp ./tlp/tlp.conf /etc/tlp.conf
	sudo cp ./pacman/pacman.conf /etc/pacman.conf
	sudo cp ./grub-theme-config.txt /boot/grub/themes/tela/theme.txt
fi

