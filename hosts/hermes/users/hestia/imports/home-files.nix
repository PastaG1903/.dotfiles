{ config, inputs, lib, ... }:
{
  home.file = {
    ".config/niri" = {
      source = config.lib.file.mkOutOfStoreSymlink /home/hestia/.dotfiles/hosts/hermes/users/hestia/configs/niri;
      recursive = true;
    };
    ".config/noctalia" = {
      source = config.lib.file.mkOutOfStoreSymlink /home/hestia/.dotfiles/hosts/hermes/users/hestia/configs/noctalia;
      recursive = true;
    };
    ".config/yazi" = {
      source = config.lib.file.mkOutOfStoreSymlink /home/hestia/.dotfiles/hosts/hermes/users/hestia/configs/yazi;
      recursive = true;
    };
    ".config/vicinae" = {
      source = config.lib.file.mkOutOfStoreSymlink /home/hestia/.dotfiles/hosts/hermes/users/hestia/configs/vicinae;
      recursive = true;
    };
    ".config/kitty" = {
      source = config.lib.file.mkOutOfStoreSymlink /home/hestia/.dotfiles/hosts/hermes/users/hestia/configs/kitty;
      recursive = true;
    };
    ".config/nvim" = {
      source = config.lib.file.mkOutOfStoreSymlink /home/hestia/.dotfiles/hosts/hermes/users/hestia/configs/nvim;
      recursive = true;
    };
    ".ssh/config" = {
      source = config.lib.file.mkOutOfStoreSymlink /home/hestia/.dotfiles/hosts/hermes/users/hestia/configs/.ssh/config;
      recursive = true;
    };

  };

}
