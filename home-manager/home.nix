{ config, pkgs, pkgs-unstable, ... }:

# On the first install of this flake, run:
# "nix run github:nix-community/home-manager -- switch --flake ~/.dotfiles/home-manager#username"

{
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
    ardour
    bottles
    brave
    freecad
    gale
    gimp
    gum
    kitty
    hydrogen
    librecad
    libreoffice-still
    lmms
    localsend
    lsd
    miracode
    mpv
    neovim
    nh
    inkscape-with-extensions
    onlyoffice-desktopeditors
    openscad
    pavucontrol
    qutebrowser
    ripdrag
    ristretto
    signal-desktop
    spotify
    syncthing
    swaybg
    teams-for-linux
    texliveFull
    tor-browser
    xwayland-satellite
    waybar
    wl-clipboard
    wl-gammarelay-applet
    wl-gammarelay-rs
    wl-mirror
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


  ] ++ (with pkgs-unstable; [
    musescore
    muse-sounds-manager

    beeper
    noctalia-shell
    steam
    vicinae

    python314Packages.matplotlib
    python314Packages.jupyter
    python314Packages.numpy
    python314Packages.pandas
    python314Packages.sympy
    python314Packages.notebook
  ]);

  home.sessionVariables = {
    NVIM_APPNAME = "leovim";
    EDITOR = "nvim";
  };

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
        source = config.lib.file.mkOutOfStoreSymlink /home/hestia/.dotfiles/home-manager/configs/niri;
	recursive = true;
      };
      ".config/noctalia" = {
        source = config.lib.file.mkOutOfStoreSymlink /home/hestia/.dotfiles/home-manager/configs/noctalia;
	recursive = true;
      };
      ".config/yazi" = {
        source = config.lib.file.mkOutOfStoreSymlink /home/hestia/.dotfiles/home-manager/configs/yazi;
	recursive = true;
      };
      ".config/vicinae" = {
        source = config.lib.file.mkOutOfStoreSymlink /home/hestia/.dotfiles/home-manager/configs/vicinae;
	recursive = true;
      };
      ".config/kitty" = {
        source = config.lib.file.mkOutOfStoreSymlink /home/hestia/.dotfiles/home-manager/configs/kitty;
	recursive = true;
      };
      ".config/leovim" = {
        source = config.lib.file.mkOutOfStoreSymlink /home/hestia/.dotfiles/home-manager/configs/leovim;
	recursive = true;
      };

  };

  programs.zathura = {
      enable = true;
      extraConfig = "set selection-clipboard clipboard";
    };

  programs.zsh = {
    enable = true;
    enableCompletion = true;

    setOptions = [
      "NO_BEEP"
    ];

    initContent = ''
      PROMPT='[%n@%m: %1~]$ '
      fastfetch
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
      hmu = "cd ~/.dotfiles/home-manager/ && nix flake update";
      hms = "home-manager switch --flake ~/.dotfiles/home-manager#$USER";
      wander = "cd ~/WANDER";
      kcl = "printf '\033c'";
      dots = "cd ~/.dotfiles";
      lsblk = "lsblk -o NAME,SIZE,TYPE,FSTYPE,MOUNTPOINTS,UUID,LABEL";
      y = "yazi";
      la = "ls -a";
      lsd = "lsd -1FX --group-dirs last";
      ls = "ls -1FX";
      checkmounted = "ps aux | grep -e sshfs";
      gna = "ssh -Y shay@10.147.17.72";
      gna_ip = "echo '10.147.17.72'";
      prometheus = "ssh shama@10.147.17.223";
      prometheus_ip = "echo 10.147.17.223";
      ping_gna = "ping -a $(gna_ip)";
      ping = "ping -a";
      pyenv = "source ~/.venvs/bin/activate";
      keymod = "sudo vim /etc/keyd/keyd.conf && sudo keyd reload";
      suspend = "systemctl suspend";
      xwr = "~/.dotfiles/bashrc/.scripts/xwr.sh";
      stirlingpdf = "sudo docker run -p 8080:8080 docker.stirlingpdf.com/stirlingtools/stirling-pdf";
      sysser = "~/.dotfiles/extras/syssertui.sh";
      chkeyd = "~/.dotfiles/keydconf";
    };
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
        "localip"
        "battery"
        "poweradapter"
        "break"
        "colors"
      ];
    };
  };

  programs.yazi = {
      enable = true;
      shellWrapperName = "y";
   };

  programs = { # general programs
      obs-studio.enable = true;
      gh.enable = true;
    };

  services = { # general services
      easyeffects.enable = true;
    };

}
