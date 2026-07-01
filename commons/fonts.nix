{ config, lib, pkgs, unstable, static, ... }:
{
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      corefonts
        adwaita-fonts
        lmodern
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-cjk-serif
        noto-fonts-emoji-blob-bin
        liberation_ttf
        aileron
        inter
        eb-garamond
        cabin
        mplus-outline-fonts.githubRelease
        dina-font
        proggyfonts
    ];
  };
}
