
{ inputs, config, pkgs, lib, unstable, ... }:
{
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

  services = {
    blueman.enable = true;
    tumbler.enable = true;
    printing = {
      enable = true;
      drivers = with pkgs; [
	gutenprint
	  hplip
	  brlaser
	  cups-filters
	  cups-browsed
      ];
    };
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

}
