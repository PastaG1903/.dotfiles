{ config, lib, pkgs, unstable, static, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    btop-rocm
    fastfetch
    fzf
    gh
    git
    neovim
    nh
    ripgrep
    rocmPackages.rocm-smi
    tmux
    unzip
    yazi
    zip
    zoxide
  ];
}
