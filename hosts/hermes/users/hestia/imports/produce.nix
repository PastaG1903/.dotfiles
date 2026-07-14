{ config, pkgs, unstable, static, ... }:

{
  home.packages = with pkgs; [
    freecad
    gimp
    librecad
    libreoffice-still
    inkscape-with-extensions
    obsidian
    onlyoffice-desktopeditors
    openscad
  ] ++ (with unstable; [
    python314Packages.matplotlib
    python314Packages.jupyter
    python314Packages.numpy
    python314Packages.pandas
    python314Packages.sympy
    python314Packages.notebook
    julia
    rustup
  ]) ++ (with static; [
    texliveFull
  ]);
}
