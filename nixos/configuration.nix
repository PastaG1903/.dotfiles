# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

# THE FOLLOWING PACKAGES WERE CONFIGURED HERE AS OPPOSED TO CONVENTIONAL SEPARATE CONFIGS:
# keyd, tlp, thinkfan
# The configurations can be accessed easily by searching for "<package> config"

{ config, pkgs, lib, unstable, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ];

# Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelParams = [ "usbhid.quirks=0x2b89:0x64ec:0x0004" ];
  boot.kernelModules = [ "i2c-dev" "ddcci" ];
  boot.extraModulePackages = [ config.boot.kernelPackages.ddcci-driver ];

  fileSystems = {
    "/".options = [ "compress=zstd" "noatime" ];
    "/home".options = [ "compress=zstd" "noatime" ];
    "/nix".options = [ "compress=zstd" "noatime" ];
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 15d";
  };

  zramSwap.enable = true;

  networking.hostName = "hermes"; # Define your hostname.
# networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

# Configure network proxy if necessary
# networking.proxy.default = "http://user:password@proxy:port/";
# networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

# Enable networking
    networking.networkmanager.enable = true;

# Set your time zone.
  time.timeZone = "America/Mexico_City";

# Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

# Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.displayManager.ly = {
    enable = true;
    settings = {
      animation = "gameoflife";
    };
  };

# Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.hestia = {
    isNormalUser = true;
    shell = pkgs.zsh;
    description = "hestia";
    extraGroups = [ "networkmanager" "wheel" "i2c" ];
    packages = with pkgs; [
    ];
  };

# Allow unfree packages
  nixpkgs.config.allowUnfree = true;

# List packages installed in system profile. To search, run:
# $ nix search wget

  environment.systemPackages = with pkgs; [
      alsa-utils
      appimage-run
      brightnessctl
      blueman
      bluez
      bluez-tools
      bluetui
      btop-rocm
      cmatrix
      ddcutil
      ddcutil-service
      dnsmasq
      docker
      easyeffects
      evince
      fastfetch
      firefox
      gcc
      gh
      git
      gnome-boxes
      jdk21_headless
      keyd
      less
      mesa
      mokutil
      nautilus
      nmap
      nodejs_26
      phodav
      playerctl
      python314
      rclone
      rocmPackages.rocm-smi
      smartmontools
      sshfs
      stow
      tealdeer
      thinkfan
      tlp
      tmux
      unzip
      vim
      wget
      xdg-desktop-portal
      xdg-desktop-portal-gnome
      zathura
      zerotierone
      zip
      zoxide
      zram-generator

#  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
#  wget
      ];

  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      corefonts
	adwaita-fonts
	lmodern
	noto-fonts
	noto-fonts-cjk-sans
	noto-fonts-cjk-serif
	noto-fonts-emoji-blob-bin
	liberation_ttf
	aileron
	inter
	eb-garamond
	cabin
	mplus-outline-fonts.githubRelease
	dina-font
	proggyfonts
    ];
  };

  virtualisation = {
    libvirtd = {
      enable = true;
#      qemu = {
#        swtpm.enable = true;
# 	 ovmf.packages = [ pkgs.OVMFFull.fd ];
#      };
    };
    spiceUSBRedirection.enable = true;
  };

  users.groups.libvirtd.members = [ "hestia" ];
  users.groups.kvm.members = [ "hestia" ];

# Some programs need SUID wrappers, can be configured further or are
# started in user sessions.
# programs.mtr.enable = true;
# programs.gnupg.agent = {
#   enable = true;
#   enableSSHSupport = true;
# };

  programs = {
    zsh.enable = true;
    niri.enable = true;
    steam.enable = true;
    nix-ld.enable = true;
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

  virtualisation.docker.enable = true;

  services = {
    openssh.enable = true;
    blueman.enable = true;
    zerotierone.enable = true;
    printing.enable = true;
    gvfs.enable = true;
    flatpak.enable = true;
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
  };

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

# thinkfan config
  services.thinkfan = {
    enable = true;
    levels = [
      ["level auto" 0 40]
	[2 40 45]
	  [4 45 55]
	    [6 55 65]
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
    STOP_CHARGE_THRESH_BAT0=81;
  };
  services.upower.enable = true;

# keyd config
  services.keyd = {
    enable = true;
    keyboards = {
      default = {
	ids = [ "*" ];
	settings = {
	  main = {
	    capslock = "lettermod(capslock,esc,150,200)";
	    leftshift = "layer(sl)";
	    rightshift = "layer(sr)";
	    space = "lettermod(vimesque,space,150,200)";
	    a = "lettermod(control,a,150,200)";
	    s = "lettermod(shift,s,150,200)";
	    d = "lettermod(alt,d,150,200)";
	    f = "lettermod(meta,f,150,200)";
	    j = "lettermod(meta,j,150,200)";
	    k = "lettermod(rightalt,k,150,200)";
	    l = "lettermod(shift,l,150,200)";
	    ";" = "lettermod(control,;,150,200)";
	    "leftshift+leftmeta+f23" = "layer(copilot)";
	  };

	  "rightalt:G" = {};

	  "sl:S" = {
	    rightshift = "capslock";
	  };

	  "sr:S" = {
	    leftshift = "capslock";
	  };

	  "copilot:C-A-S-M" = {};

	  "capslock:C" = {
	    ";" = "backspace";
	    space = "0";
	    m = "1";
	    "," = "2";
	    "." = "3";
	    j = "4";
	    k = "5";
	    l = "6";
	    u = "7";
	    i = "8";
	    o = "9";
	  };

	  vimesque = {
	    m = "playpause";
	    "." = "nextsong";
	    "," = "previoussong";
	    h = "left";
	    j = "down";
	    k = "up";
	    l = "right";
	    i = "home";
	    a = "end";
	    e = "C-right";
	    w = "C-left";
	    y = "macro(home S-end C-c)";
	    p = "C-v";
	    "/" = "C-f";
	    ";" = "C-A-t";
	    d = "macro(home S-end C-x backspace)";
	    enter = "compose";
	    g = "pageup";
	    f = "pagedown";
	    x = "delete";
	    u = "insert";
	    o = "macro(end enter)";
	    v = "macro(home S-end)";
	  };
	};
      };
      mouse = {
	ids = [ "32c2:0012" ];
	settings = {
	  main = {
	    "leftmouse+rightmouse" = "middlemouse";
	    "mouse1+mouse2" = "toggle(zeta)";
	    mouse1 = "overload(beta,mouse1)";
	    mouse2 = "overload(alpha,mouse2)";
	    middlemouse = "toggle(gamma)";
	  };

	  "alpha:M" = {
	    leftmouse = "C-insert";
	    rightmouse = "S-insert";
	    middlemouse = "M-q";
	  };

	  "beta:S" = {
	    leftmouse = "C-A-o";
	    rightmouse = "M-r";
	    middlemouse = "C-space";
	  };

	  "alpha+beta" = {
	    rightmouse = "M-S-r";
	  };

	  gamma = {
	    mouse1 = "overload(delta,mouse1)";
	    mouse2 = "overload(epsilon,mouse2)";
	  };

	  "delta:C-S" = {
	    leftmouse = "previoussong";
	    rightmouse = "nextsong";
	    mouse2 = "playpause";
	  };

	  "epsilon:M-C-A" = {
	    leftmouse = "mute";
	    rightmouse = "micmute";
	  };

	  zeta = {
	    mouse1 = "overload(eta,mouse1)";
	    mouse2 = "overload(theta,theta2)";
	  };

	  "eta:S" = {};
	  "theta:C" = {};
	};
      };
    };
  };

# Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 53317 8888 8384];
  networking.firewall.allowedUDPPorts = [ 53317 8888 8384];
# Or disable the firewall altogether.
# networking.firewall.enable = false;

# system.autoUpgrade.enable = true;
# system.autoUpgrade.allowReboot = true;

# This value determines the NixOS release from which the default
# settings for stateful data, like file locations and database versions
# on your system were taken. It‘s perfectly fine and recommended to leave
# this value at the release version of the first install of this system.
# Before changing this value read the documentation for this option
# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?

}
