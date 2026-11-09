{ config, stable, unstable, ... }:
{
  home.packages = with unstable; [
    steam
    vicinae
    noctalia
  ] ++ (with pkgs; [
    beeper
  ]);
}
