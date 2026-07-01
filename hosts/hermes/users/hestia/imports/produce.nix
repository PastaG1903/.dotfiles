{ config, pkgs, unstable, static, ... }:

{
  home.packages = with pkgs; [
    freecad
    gimp
    librecad
    libreoffice-still
    inkscape-with-extensions
    onlyoffice-desktopeditors
    openscad
  ] ++ (with unstable; [
    python314Packages.matplotlib
    python314Packages.jupyter
    python314Packages.numpy
    python314Packages.pandas
    python314Packages.sympy
    python314Packages.notebook
  ]) ++ (with static; [
    texliveFull
  ]);
}
