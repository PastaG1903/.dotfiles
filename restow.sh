#!/bin/bash

rm ~/.bashrc
rm ~/.zshrc

list=""
for elem in $(lsd -1FX | grep /); do
	if [ "$elem" != "grub/" ] && [ "$elem" != "keyd/" ] && [ "$elem" != "thinkfan/" ] && [ "$elem" != "tlp/" ] && [ "$elem" != "pacman/" ]; then
		list="$list ${elem::-1}"
	fi
done

for elem in $list; do
	sudo stow "$elem"
done

if [ "$@" = "-nohome" ]; then
	sudo rm /etc/default/grub
	sudo stow --target=/etc/default/ grub
	sudo stow --target=/etc/ keyd
	sudo cp ./thinkfan/thinkfan.hook /usr/lib/systemd/system-sleep/thinkfan
	sudo cp ./thinkfan/thinkfan.yaml /etc/thinkfan.yaml
	sudo cp ./tlp/tlp.conf /etc/tlp.conf
	sudo cp ./pacman/pacman.conf /etc/pacman.conf
	sudo mkdir -p /etc/pacman.d/hooks
	sudo cp ./pacman/paccache-hook.hook /etc/pacman.d/hooks/
	sudo cp ./grub-theme-config.txt /boot/grub/themes/tela/theme.txt
fi

