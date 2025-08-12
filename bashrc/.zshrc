﻿#
# ~/.zshrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PROMPT='[%n@%m: %1~]$ '
setopt no_beep
#set -o vi

export NVIM_APPNAME="leovim"
export EDITOR="nvim"

alias zshrc="nvim ~/.zshrc"
alias zrc="nvim ~/.zshrc && source ~/.zshrc"
alias kcl="printf '\033c'"

alias wander="cd /run/media/mavap/WANDER/"
alias dots="cd ~/.dotfiles"

alias lsblk="lsblk -o NAME,SIZE,TYPE,FSTYPE,MOUNTPOINTS,LABEL"

alias open="thunar &"
alias y="yazi"
alias py="python"
alias reload="source ~/.zshrc"
alias tesis="cd ~/OneDrive_scul/MNT/Tesis/TrueThesisFormat/thesis_format/ && nvim ./main.tex"
alias mnt="cd ~/OneDrive_scul/MNT"
alias todo="cd ~/OneDrive/MNT/ && py ./todo.py && cd"
alias ODP="cd ~/OneDrive_Personal"
alias tpgf="cd ~/OneDrive_Personal/The\ PastaGuy\'s\ Files/"
alias pbp="cd ~/OneDrive_Personal/The\ PastaGuy\'s\ Files/PBP"
alias syg="cd ~/.VAPS/.sys/"
alias la="ls -a"
alias lsd='lsd -1FX --group-dirs last'
alias ls="ls -1FX"
alias nvimc='nvim --clean'
alias clc="clear"
eval "$(zoxide init zsh)"

alias ZTO="sudo systemctl restart zerotier-one sshd"

alias checkmounted="ps aux | grep -e sshfs"

#alias gna="ssh shay@172.26.138.199"
alias gna="ssh shay@10.147.17.30"
alias fenrir="ssh shay@172.26.203.58"
#alias gna_ip="echo 'Gna ip: 172.26.138.199'"
alias gna_ip="echo '10.147.17.30'"
alias fenrir_ip="echo '172.26.203.58'"
alias gallus_ip="echo '172.26.183.158'"

alias ping_gna="ping -a $(gna_ip)"
alias ping="ping -a"
alias ping_phone="ping 172.26.63.165"
#alias ping_gna="ping $(gna_ip) | while read line; do canberra-gtk-play -i bell; echo "$line"; done"

alias grub-make-config="sudo grub-mkconfig -o /boot/grub/grub.cfg"

alias pyenv="source ~/.venvs/bin/activate"

alias caps2hyper="setxkbmap -option caps:hyper"
alias keymod="sudo vim /etc/keyd/keyd.conf && sudo keyd reload"
alias xlogout="xfce4-session-logout"
alias suspend="systemctl suspend"
alias display-on="hyprclt dispatch dpms on"
alias tlpconf="sudo nvim /etc/tlp.conf && sudo systemctl restart tlp"

#MOUNTING & UMOUNTING DRIVES ALIASES
alias mount-gna="sshfs shay@10.147.17.30:/home/shay/ ~/Desktop/Drives/Gna/"
alias umount-gna="umount ~/Desktop/Drives/Gna/"
alias mount-fenrir="sshfs shay@172.26.203.58:home/shay/ ~/Desktop/Drives/Fenrir/"
alias umoun-fenrir="umount ~/Desktop/Drives/Fenrir/"

#PROGRAMS & UTILS ALIASES
alias matlab="~/Documents/MATLAB/bin/matlab"

alias chkeyd="~/.dotfiles/keydconf"

alias sysser="~/.dotfiles/bashrc/.scripts/WIND_TUIs/syssertui.sh"
alias iwdtui="~/.dotfiles/bashrc/.scripts/WIND_TUIs/iwdtui.sh"

alias pomodoro="~/.dotfiles/bashrc/pomodoro.sh"

alias jekyllserve="bundle exec jekyll serve"
export PATH="$HOME/WANDER/ORCA/orca:$PATH"
export LD_LIBRARY_PATH="$HOME/WANDER/ORCA/orca/lib/:$LD_LIBRARY_PATH"
alias mount_WANDER="sudo mount /dev/sda1 ~/WANDER/"
alias umount_WANDER="sudo umount ~/WANDER/"

yazi() {
    local tmp="$(mktemp)"
    command yazi "$@" --cwd-file "$tmp"
    if [ -s "$tmp" ]; then
        cd "$(cat "$tmp")"
    fi
    rm -f "$tmp"
}


###  ###
alias ff="fastfetch"
kcl && fastfetch
