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
  boot.blacklistedKernelModules = [ "amdgpu" ];

  zramSwap = {
    enable = true;
  };

  networking.hostName = "ludovico"; # Define your hostname.

  nixpkgs.config.allowUnfree = true;

  networking.networkmanager.enable = true;

  time.timeZone = "America/Monterrey";

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  security.rtkit.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  services.logind = {
     lidSwitch = "ignore";
     lidSwitchDocked = "ignore";
  };

  services.displayManager.sddm.enable = true;
  services.displayManager.defaultSession = "steam";
  services.displayManager.autoLogin = {
    enable = true;
    user = "ludwig";
  };
  
  services.zerotierone.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ludwig = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "input" "audio" ]; # Enable ‘sudo’ for the user.
    initialPassword = "password";
    packages = with pkgs; [
    ];
  };
  users.users.console = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "input" "audio" ];
    initialPassword = "password";
  };

  # List packages installed in system profile.
  environment.etc."wireplumber/wireplumber.conf.d/51-ludovico-hdmi.conf".text = ''
    monitor.alsa.rules = [
      {
        matches = [ { node.name = "~alsa_output.*hdmi.*" } ]
	actions = { update-props = { priority.session = 2000 } }
      }
    ]
    '';
  environment.systemPackages = with pkgs; [
    alsa-utils
  ] ++ config.services.displayManager.sessionPackages;

  programs.gamescope = {
    enable = true;
    capSysNice = true;
  };

  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
    remotePlay.openFirewall = true;
  };

  programs.gamemode.enable = true;

  services = {
    openssh.enable = true;
    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  system.stateVersion = "25.11"; # Did you read the comment?

}

