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
      hms = "cd ~/.dotfiles && nh home switch . -c shay && cd -";
      sys-update-switch = "cd ~/.dotfiles && nh os switch . -H gna && cd -";
      sys-update-boot = "cd ~/.dotfiles && nh os boot . -H gna && cd -";
      fzf = "fzf --preview 'bat --style=numbers --color=always {}'";
      dots = "cd ~/.dotfiles";
      lsblk = "lsblk -o NAME,SIZE,TYPE,FSTYPE,MOUNTPOINTS,UUID,LABEL";
      y = "yazi";
      la = "ls -a";
      lsd = "lsd -1FX --group-dirs last";
      ls = "ls -1FX";
      ping_gna = "ping -a $(gna_ip)";
      ludovico = "ssh console@10.147.17.236";
      ludovico_ip = "echo '10.147.17.236'";
      ping = "ping -a";
      stirlingpdf = "sudo docker run -p 8080:8080 docker.stirlingpdf.com/stirlingtools/stirling-pdf";
      sysser = "~/.dotfiles/extras/syssertui.sh";
    };
  };
}
