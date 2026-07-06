{ config, pkgs, unstable, static, ... }:

# On the first install of this flake, run:
# "nix run github:nix-community/home-manager -- switch --flake ~/.dotfiles#username"

{
  imports = [
    ./imports/cmd.nix
    ./imports/music.nix
    ./imports/zshrc.nix
    ./imports/produce.nix
    ./imports/unstable.nix
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

    bottles
    gnome-boxes

    brave
    qutebrowser
    firefox
    tor-browser

    qpdfview
    ristretto
    zathura

    jabref
    localsend
    nautilus
    syncthing

    mpv
    pavucontrol

    gale
    miracode
    swaybg
    xwayland-satellite
    wl-clipboard
    wl-gammarelay-applet
    wl-gammarelay-rs
    wl-mirror

    teams-for-linux
    zoom-us

    # for screen-toolkit noctalia plugin
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
  ];

  # xdg = {
  #   enable = true;
  #   userDirs = {
  #     enable = true;
  #     createDirectories = true;
  #     setSessionVariables = false;
  #   };
  # };

  home.file = {
      ".config/niri" = {
        source = config.lib.file.mkOutOfStoreSymlink /home/hestia/.dotfiles/hosts/hermes/users/hestia/configs/niri;
	recursive = true;
      };
      ".config/noctalia" = {
        source = config.lib.file.mkOutOfStoreSymlink /home/hestia/.dotfiles/hosts/hermes/users/hestia/configs/noctalia;
	recursive = true;
      };
      ".config/yazi" = {
        source = config.lib.file.mkOutOfStoreSymlink /home/hestia/.dotfiles/hosts/hermes/users/hestia/configs/yazi;
	recursive = true;
      };
      ".config/vicinae" = {
        source = config.lib.file.mkOutOfStoreSymlink /home/hestia/.dotfiles/hosts/hermes/users/hestia/configs/vicinae;
	recursive = true;
      };
      ".config/kitty" = {
        source = config.lib.file.mkOutOfStoreSymlink /home/hestia/.dotfiles/hosts/hermes/users/hestia/configs/kitty;
	recursive = true;
      };
      ".config/leovim" = {
        source = config.lib.file.mkOutOfStoreSymlink /home/hestia/.dotfiles/hosts/hermes/users/hestia/configs/leovim;
	recursive = true;
      };

  };

  programs.zathura = {
      enable = true;
      extraConfig = "set selection-clipboard clipboard";
    };

  programs.fastfetch = {
    enable = true;

    settings = {
      "$schema" = "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json";

      logo = {
        source = "~/Desktop/full_vaps.png";
        width = 10;
      };

      modules = [
        "title"
        "separator"
        "os"
        "host"
        "kernel"
        "uptime"
        {
          type = "command";
          key = "Days alive";
          text = "echo $(($(date +%s)/86400 - $(stat -c %W /)/86400))";
        }
        "packages"
        "shell"
        "display"
        "de"
        "wm"
        "terminal"
        "terminalfont"
        "cpu"
        "gpu"
        "memory"
        "swap"
        "disk"
        "btrfs"
        "localip"
        "battery"
        "poweradapter"
        "break"
        "colors"
      ];
    };
  };

  programs = { # general programs
      obs-studio.enable = true;
      gh.enable = true;
    };

}
