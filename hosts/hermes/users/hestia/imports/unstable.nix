{ config, unstable, ... }:
{
  home.packages = with unstable; [
    beeper
    steam
    vicinae
  ];
}
