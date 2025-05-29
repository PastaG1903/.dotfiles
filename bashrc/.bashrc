#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export NVIM_APPNAME="leovim"
export EDITOR="nvim"

alias bashrc="nvim ~/.bashrc"
alias brc="nvim ~/.bashrc && source ~/.bashrc"
alias kcl="printf '\033c'"

alias wander="cd /run/media/mavap/WANDER/"
alias dots="cd ~/.dotfiles"

alias open="thunar &"
alias y="yazi"
alias py="python"
alias reload="source ~/.bashrc"
alias mnt="cd ~/OneDrive_scul/MNT"
alias todo="cd ~/OneDrive/MNT/ && py ./todo.py && cd"
alias ODP="cd ~/OneDrive_Personal"
alias tpgf="cd ~/OneDrive_Personal/The\ PastaGuy\'s\ Files/"
alias pbp="cd ~/OneDrive_Personal/The\ PastaGuy\'s\ Files/PBP"
alias syg="cd ~/.VAPS/.sys/"
alias la="ls -a"
alias lsd='lsd -1FX --group-dirs last'
alias nvimc='nvim --clean'
alias clc="clear"
PS1='[\u@\h \W]\$ '
eval "$(zoxide init bash)"

alias ZTO="sudo systemctl restart zerotier-one sshd"

alias gna="ssh shay@172.26.138.199"
alias fenrir="ssh shay@172.26.203.58"
alias gna_ip="echo 'Gna ip: 172.26.138.199'"
alias fenrir_ip="echo 'Fenrir ip: 172.26.203.58'"
alias gallus_ip="echo 'Gallus ip: 172.26.183.158'"

alias grub-make-config="sudo grub-mkconfig -o /boot/grub/grub.cfg"

alias pyenv="source ~/.venvs/bin/activate"

alias caps2hyper="setxkbmap -option caps:hyper"
alias keymod="sudo nvim /etc/keyd/keyd.conf && sudo keyd reload"
alias xlogout="xfce4-session-logout"
alias suspend="systemctl suspend"
alias display-on="hyprclt dispatch dpms on"

#MOUNTING & UMOUNTING DRIVES ALIASES
alias mount-gna="sshfs shay@172.26.138.199:/home/shay/ /home/mavap/Desktop/Drives/Gna/"
alias umount-gna="umount /home/mavap/Desktop/Drives/Gna/"
alias mount-fenrir="sshfs shay@172.26.203.58:home/shay/ /home/mavap/Desktop/Drives/Fenrir/"
alias umoun-fenrir="umount /home/mavap/Desktop/Drives/Fenrir/"

alias FM="cd /home/mavap/Desktop/Drives/FlashMich/"

#PROGRAMS & UTILS ALIASES
alias matlab="/home/mavap/Downloads/MATLAB/bin/matlab"

alias lvim='NVIM_APPNAME="leovim" nvim'

alias sysser="/home/mavap/.dotfiles/bashrc/.scripts/WIND_TUIs/syssertui.sh"
alias iwdtui="/home/mavap/.dotfiles/bashrc/.scripts/WIND_TUIs/iwdtui.sh"

alias jekyllserve="bundle exec jekyll serve"
export PATH="/home/mavap/.local/share/gem/ruby/3.3.0/bin:$PATH"
export TEXMFCNF=$HOME/texmf/web2c:

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
fastfetch
