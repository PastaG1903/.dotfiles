{ config, lib, pkgs, unstable, static, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    btop-rocm
    distrobox
    dnsmasq
    docker
    fastfetch
    fzf
    gcc
    gh
    git
    less
    neovim
    nh
    nmap
    python314
    ripgrep
    rocmPackages.rocm-smi
    smartmontools
    sshfs
    tealdeer
    tmux
    unzip
    wget
    yazi
    zerotierone
    zip
    zoxide
  ];
}
