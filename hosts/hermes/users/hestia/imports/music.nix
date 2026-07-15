{ config, pkgs, unstable, static, ... }:

{
  home.packages = with pkgs; [
    ardour
    audacity
    hydrogen
    lmms
    spotify
  ] ++ (with unstable; [
    muse-sounds-manager
  ]) ++ (with static; [
    musescore
  ]);

  services.easyeffects.enable = true;
}
