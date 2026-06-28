{ config, pkgs, unstable, static, ... }:

{
  home.packages = with pkgs; [
    bat
    gum
    kitty
    lsd
    ripdrag
  ];

  home.sessionVariables = {
    NVIM_APPNAME = "leovim";
    EDITOR = "nvim";
  };

  programs.yazi = {
      enable = true;
      shellWrapperName = "y";
  };
}
