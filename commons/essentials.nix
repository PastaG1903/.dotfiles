{ config, lib, pkgs, unstable, static, ... }:

{
  imports = [
    ./pkgs.nix
  ];
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 15d";
  };

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
