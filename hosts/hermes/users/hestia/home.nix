{ config, lib, pkgs, unstable, static, inputs, ... }:

# On the first install of this flake, run:
# "nix run github:nix-community/home-manager -- switch --flake ~/.dotfiles#username"

{
  imports = [
    ./imports/cmd.nix
    ./imports/music.nix
    ./imports/zshrc.nix
    ./imports/produce.nix
    ./imports/unstable.nix
    ./imports/home-files.nix
    ./imports/fastfetch-config.nix
  ];
  
  home.username = "hestia";
  home.homeDirectory = "/home/hestia";
  home.stateVersion = "25.11";
  programs.home-manager.enable = true;

  nixpkgs.config.allowUnfree = true;

  home.pointerCursor = {
    x11.enable = true;
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Original-Classic";
  };

  home.packages = with pkgs; [

    gnome-boxes

    brave
    tor-browser

    qpdfview
    simple-scan
    ristretto
    zathura

    jabref
    localsend
    nautilus
    scrcpy

    mpv
    pavucontrol
    shotcut

    chameleos #annotations for Niri
    gale
    r2modman
    miracode
    owmods-gui
    swaybg
    xwayland-satellite
    wl-clipboard
    wl-gammarelay-applet
    wl-gammarelay-rs
    wl-mirror

    teams-for-linux
    zoom-us

    # for screen-toolkit Noctalia V4 plugin
    grim
    slurp
    tesseract
    imagemagick
    zbar
    ffmpeg
    jq
    wl-screenrec
    hyprpicker
    python313
    python313Packages.pygobject3
  ] ++ (with static; [
    noctalia-shell
  ]);

  # xdg = {
  #   enable = true;
  #   userDirs = {
  #     enable = true;
  #     createDirectories = true;
  #     setSessionVariables = false;
  #   };
  # };


  programs.zathura = {
      enable = true;
      extraConfig = "set selection-clipboard clipboard";
    };

  programs = { # general programs
      obs-studio.enable = true;
      gh.enable = true;
    };

}
