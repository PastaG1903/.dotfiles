{ config, pkgs, unstable, static, ... }:

{
  home.packages = with pkgs; [
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
