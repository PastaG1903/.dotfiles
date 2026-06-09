{ config, pkgs, pkgs-unstable, ... }:

# On the first install of this flake, run:
# "nix run github:nix-community/home-manager -- switch --flake ~/.config/home-manager#username"

{
  home.username = "hestia";
  home.homeDirectory = "/home/hestia";
  home.stateVersion = "25.11";
  programs.home-manager.enable = true;

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    ardour
    brave
    freecad
    gimp
    kitty
    hydrogen
    librecad
    libreoffice-still
    lmms
    localsend
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

  # home.file = {
      # ".config/niri".source = ./configs/niri;
      # ".config/noctalia".source = ./configs/noctalia;
      # ".config/yazi".source = ./configs/yazi;
      # ".config/vicinae".source = ./configs/vicinae;
      # ".config/leovim".source = ./configs/leovim;

    # };

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
      hms = "cd ~/.dotfiles/home-manager/ && nix flake update && home-manager switch --flake ~/.dotfiles/home-manager#$USER";
      wander = "cd ~/WANDER";
      kcl = "printf '\033c'";
      dots = "cd ~/.dotfiles";
      lsblk = "lsblk -o NAME,SIZE,TYPE,FSTYPE,MOUNTPOINTS,UUID,LABEL";
      y = "yazi";
      la = "ls -a";
      lsd = "lsd -1FX --group-dirs last";
      ls = "ls -1FX";
      checkmounted = "ps aux | grep -e sshfs";
      gna = "ssh -X shay@10.147.17.30";
      gna_ip = "echo '10.147.17.30'";
      prometheus = "ssh shama@10.147.17.223";
      prometheus_ip = "echo 10.147.17.223";
      ping_gna = "ping -a $(gna_ip)";
      ping = "ping -a";
      pyenv = "source ~/.venvs/bin/activate";
      keymod = "sudo vim /etc/keyd/keyd.conf && sudo keyd reload";
      suspend = "systemctl suspend";
      xwr = "~/.dotfiles/bashrc/.scripts/xwr.sh";
      stirlingpdf = "sudo docker run -p 8080:8080 docker.stirlingpdf.com/stirlingtools/stirling-pdf";
      chkeyd = "~/.dotfiles/keydconf";
    };
  };

  # programs.kitty = {
  #   enable = true;
  #
  #   font = {
  #     name = "Miracode";
  #     package = pkgs.miracode;
  #     size = 16.0;
  #   };
  #
  #   settings = {
  #     cursor_trail = 1;
  #     bold_font = "auto";
  #     italic_font = "auto";
  #     bold_italic_font = "auto";
  #   };

    # theme colors inlined directly — replaces current-theme.conf
    # extraConfig = ''
    #   color0 #0f1513
    #   color1 #00fa9b
    #   color2 #a0a0ff
    #   color3 #a5cfc2
    #   color4 #40d9b2
    #   color5 #ffb4a6
    #   color6 #a5cfc2
    #   color7 #dee4e0
    #   color8 #86948e
    #   color9 #ffb4ab
    #   color10 #ffbaad
    #   color11 #a5cfc2
    #   color12 #00fa9b
    #   color13 #ffb4a6
    #   color14 #a5cfc2
    #   color15 #dee4e0
    #
    #   cursor                #dee4e0
    #   cursor_text_color     #0f1513
    #   background            #0f1513
    #   foreground            #dee4e0
    #   selection_foreground  #bccac4
    #   selection_background  #3d4945
    #   url_color             #6bdec2
    # '';
  # };

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
