{ config, lib, pkgs, unstable, static, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  programs.lazygit.enable = true;

  # Could be replaced with home.packages in case of using third-party host
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
