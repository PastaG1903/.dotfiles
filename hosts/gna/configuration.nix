{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ../../commons/essentials.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  fileSystems = {
    "/".options = [ "compress=zstd" "noatime" ];
    "/home".options = [ "compress=zstd" "noatime" ];
  };

  zramSwap.enable = true;

  networking.hostName = "gna"; # Define your hostname.

  networking.networkmanager.enable = true;

  time.timeZone = "America/Monterrey";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  i18n.defaultLocale = "en_US.UTF-8";

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    xkb = {
      layout = "us";
      variant = "";
    };
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.shay = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    packages = with pkgs; [
    ];
  };

  programs.firefox.enable = true;
  programs = {
    zsh.enable = true;
    nix-ld.enable = true;
  };

  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile.
  environment.systemPackages = with pkgs; [
    bluez
    bluez-tools
    jdk21_headless
    tlp
    zram-generator
  ];

  virtualisation.docker.enable = true;

  systemd.services.syncthing = {
    after = [ "home-shay-Z\\x2dDrive.mount" ];
    requires = [ "home-shay-Z\\x2dDrive.mount" ];
  };

  services = {
    zerotierone.enable = true;
    gvfs.enable = true;
    flatpak.enable = true;
    udisks2.enable = true;
    fwupd.enable = true;
    syncthing = {
      enable = true;
      guiAddress = "0.0.0.0:8384";
    };
    logind = {
      settings.Login.HandleLidSwitch = "ignore";
      settings.Login.HandleLidSwitchDocked = "ignore";
    };
  };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.openssh.settings.X11Forwarding = true;

  xdg.portal = {
    enable = true;
    configPackages = [ pkgs.xdg-desktop-portal-gtk pkgs.xdg-desktop-portal-gnome ];
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-gnome
    ];
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  system.stateVersion = "25.11"; # Did you read the comment?

}

