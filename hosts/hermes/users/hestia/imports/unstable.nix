{ config, stable, unstable, ... }:
{
  home.packages = with unstable; [
    steam
    vicinae
  ] ++ (with pkgs; [
    beeper
  ]);
}
