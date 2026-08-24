{ config, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;

    setOptions = [
      "NO_BEEP"
    ];

    initContent = ''
      PROMPT='[%n@%m: %1~]$ '
      fastfetch
      eval "$(zoxide init zsh --cmd cd)"
      source <(fzf --zsh)
      yazi() {
          local tmp="$(mktemp)"
          command yazi "$@" --cwd-file "$tmp"
          if [ -s "$tmp" ]; then
              cd "$(cat "$tmp")"
          fi
          rm -f "$tmp"
      }
    '';

    shellAliases = {
      flatpak-add-repo = "flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo";
      flake-update = "cd ~/.dotfiles && nix flake update && cd -";
      hms = "cd ~/.dotfiles && nh home switch . -c hestia && cd -";
      sys-update-switch = "cd ~/.dotfiles && nh os switch . -H hermes && cd -";
      sys-update-boot = "cd ~/.dotfiles && nh os boot . -H hermes && cd -";
      fzf = "fzf --preview 'bat --style=numbers --color=always {}'";
      wander = "cd ~/WANDER";
      dots = "cd ~/.dotfiles";
      lsblk = "lsblk -o NAME,SIZE,TYPE,FSTYPE,MOUNTPOINTS,UUID,LABEL";
      y = "yazi";
      la = "ls -a";
      lsd = "lsd -1FX --group-dirs last";
      ls = "ls -1FX";
      checkmounted = "ps aux | grep -e sshfs";
      gna = "ssh -Y shay@10.147.17.72";
      gna_ip = "echo '10.147.17.72'";
      ping_gna = "ping -a $(gna_ip)";
      ludovico = "ssh console@10.147.17.236";
      ludovico_ip = "echo '10.147.17.236'";
      ping = "ping -a";
      pyenv = "source ~/.venvs/bin/activate";
      keymod = "sudo vim /etc/keyd/keyd.conf && sudo keyd reload";
      suspend = "systemctl suspend";
      xwr = "~/.dotfiles/bashrc/.scripts/xwr.sh";
      stirlingpdf = "sudo docker run -p 8080:8080 docker.stirlingpdf.com/stirlingtools/stirling-pdf";
      jupyter-shell = "cd ~/.dotfiles/shells/ && nix develop ./\#jupyter";
      sysser = "~/.dotfiles/extras/syssertui.sh";
      zdrive-pull = "rsync -azv shay@10.147.17.72:/home/shay/Z-Drive/Drive/ /home/hestia/Z-Drive/";
      zdrive-push = "rsync -azv /home/hestia/Z-Drive/ shay@10.147.17.72:/home/shay/Z-Drive/Drive/";
      # chkeyd = "~/.dotfiles/keydconf";
    };
  };
}
