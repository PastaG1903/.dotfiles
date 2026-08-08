# THE FOLLOWING PACKAGES WERE CONFIGURED HERE AS OPPOSED TO CONVENTIONAL SEPARATE CONFIGS:
# keyd, tlp, thinkfan
# The configurations can be accessed easily by searching for "<package> config"

{ inputs, config, pkgs, lib, unstable, static, ... }:

{
  imports =
    [
    ./hardware-configuration.nix
    ../../commons/essentials.nix
    ../../commons/fonts.nix
    ./modules/keyd.nix
    ./modules/boot-n-fs.nix

    inputs.noctalia-greeter.nixosModules.default
    ];


  networking.hostName = "hermes"; # Define your hostname.

  networking.networkmanager.enable = true;

  time.timeZone = "America/Mexico_City";

  i18n.defaultLocale = "en_US.UTF-8";

# Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  programs.noctalia-greeter = {
      enable = true;
      settings = {
          cursor = {
              theme = "Bibata-Original-Classic";
              size = 24;
            };
        };
    };

  services.greetd = {
      enable = true;
      settings = {
          default_session = {
              command = "/run/current-system/sw/bin/noctalia-greeter-session";
              user = "greeter";
            };
        };
    };

  # services.displayManager.ly = {
  #   enable = true;
  #   settings = {
  #     animation = "gameoflife";
  #     gameoflife_entropy_interval = 0;
  #     bigclock = "en";
  #     bigclock_seconds = "true";
  #     input_len = 40; # input boxes length
  #     show_tty = "true";
  #     vi_mode = "true";
  #     vi_default_mode = "normal";
  #   };
  # };

# Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.hestia = {
    isNormalUser = true;
    shell = pkgs.zsh;
    description = "hestia";
    extraGroups = [ "networkmanager" "wheel" "i2c" "dialout" ];
    subUidRanges = [{ startUid = 100000; count = 65536; }];
    subGidRanges = [{ startGid = 100000; count = 65536; }];
  };

  environment.systemPackages = with pkgs; [
    alsa-utils
    appimage-run
    brightnessctl
    blueman
    bluez
    bluez-tools
    bluetui
    cmatrix
    ddcutil
    ddcutil-service
    easyeffects
    jdk21_headless
    keyd
    mesa
    mokutil
    nodejs_26
    phodav
    pipewire
    playerctl
    thinkfan
    tlp
    xdg-desktop-portal
    xdg-desktop-portal-gnome
    zram-generator

    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  users.groups.libvirtd.members = [ "hestia" ];
  users.groups.kvm.members = [ "hestia" ];

  virtualisation = {
    podman = {
      enable = true;
    };
    libvirtd = {
      enable = true;
    };
    spiceUSBRedirection.enable = true;
  };

  programs = {
    niri.enable = true;
    steam.enable = true;
    steam.gamescopeSession.enable = true;
    gamemode.enable = true;
    zoom-us.enable = true;
    niri.useNautilus = true;
    nautilus-open-any-terminal = {
      enable = true;
      terminal = "kitty";
    };
    appimage = {
      enable = true;
      binfmt = true;
    };
  };

  hardware = {
    i2c.enable = true;
    bluetooth.enable = true;
    alsa = {
      cardAliases = {
        soundy = { driver = "snd_hda_intel"; id = 1; };
      };
    };
    graphics.enable = true;
    cpu.amd.updateMicrocode = true;
    steam-hardware.enable = true;
  };

  services = {
    blueman.enable = true;
    tumbler.enable = true;
    printing.enable = true;
    gvfs.enable = true;
    flatpak = {
      enable = true;
      overrides = {
        "app.zen_browser.zen".Context.filesystems = [ "xdg-download" ];
      };
    };
    ddccontrol.enable = true;
    fwupd.enable = true;
  };

  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-gnome
    ];
    config.niri.default = [ "gnome" "gtk" ];
    config.common.default = [ "gnome" "gtk" ];
  };

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
    jack.enable = true;
  };

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  services.udev.extraRules = ''
    SUBSYSTEM=="tty", ATTRS{idVendor}=="1a86", ATTRS{idProduct}=="7523", ATTRS{serial}=="PRINTER_SERIAL", SYMLINK+="printer0"
    SUBSYSTEM=="tty", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="5740", ATTRS{serial}=="SERVO_SERIAL", SYMLINK+="servo0"
  '';

# thinkfan config
  services.thinkfan = {
    enable = true;
    levels = [
      ["level auto" 0 40]
      [3 40 45]
      [5 45 55]
      [7 55 65]
      ["level full-speed" 65 255]
    ];
  };

# tlp config
  services.tlp.enable = true;
  services.tlp.settings = {
    CPU_SCALING_GOVERNOR_ON_AC="performance";
    CPU_SCALING_GOVERNOR_ON_BAT="powersave";
    CPU_ENERGY_PERF_POLICY_ON_AC="performance";
    CPU_ENERGY_PERF_POLICY_ON_BAT="balance_power";
    PLATFORM_PROFILE_ON_AC="performance";
    PLATFORM_PROFILE_ON_BAT="low-power";
    START_CHARGE_THRESH_BAT0=40;
    STOP_CHARGE_THRESH_BAT0=80;
  };
  services.upower.enable = true;

# keyd config
# It has been moved to ./modules/keyd.nix

# Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 53317 8888 8384];
  networking.firewall.allowedUDPPorts = [ 53317 8888 8384];
# Or disable the firewall altogether.
# networking.firewall.enable = false;

  system.stateVersion = "25.11"; # Did you read the comment?
}
