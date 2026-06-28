{ config, lib, pkgs, unstable, static, ... }:

{

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 15d";
  };

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

  virtualisation = {
    docker.enable = true;
    libvirtd = {
      enable = true;
    };
    spiceUSBRedirection.enable = true;
  };

  programs = {
    neovim = {
      enable = true;
      defaultEditor = true;
    };
    zsh.enable = true;
    nix-ld.enable = true;
  };

  services = {
    openssh.enable = true;
    zerotierone = {
      enable = true;
      joinNetworks = [
        "a0cbf4b62a942f2f"
      ];
    };
  };

}
