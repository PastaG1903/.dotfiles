{ config, pkgs, unstable, static, ... }:

{
  home.packages = with pkgs; [
    ardour
    hydrogen
    lmms
    spotify
  ] ++ (with unstable; [
    musescore
    muse-sounds-manager
  ]);

  services.easyeffects.enable = true;
}
