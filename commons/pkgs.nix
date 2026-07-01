{ config, lib, pkgs, unstable, static, ... }:

{
  imports = [ ./ppu.nix ];

  environment.systemPackages = with pkgs; [
    distrobox
    dnsmasq
    docker
    gcc
    less
    nmap
    python314
    smartmontools
    sshfs
    tealdeer
    wget
    zerotierone
  ];
}
