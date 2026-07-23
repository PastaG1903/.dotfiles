{ config, pkgs, unstable, static, ... }:

# On the first install of this flake, run:
# "nix run github:nix-community/home-manager -- switch --flake ~/.dotfiles#username"

{
  imports = [
    ./imports/cmd.nix
    ./imports/zshrc.nix
    ./imports/produce.nix
  ];
  
  home.username = "shay";
  home.homeDirectory = "/home/shay";
  home.stateVersion = "25.11";
  programs.home-manager.enable = true;

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    nh
  ];

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
      gh.enable = true;
    };

}
