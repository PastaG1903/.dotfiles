{ config, unstable, ... }:
{
  home.packages = with unstable; [
    beeper
    noctalia-shell
    steam
    vicinae
  ];
}
