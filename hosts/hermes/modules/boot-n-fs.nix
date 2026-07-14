{ config, pkgs, lib, unstable, static, ... }:
{
# Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelParams = [ "usbhid.quirks=0x2b89:0x64ec:0x0004" 
    "resume_offset=61744384" # run "btrfs inspect-internal map-swapfile /swap/swapfile" to get the correct offset
    "zswap.enabled=1"
    "zswap.compressor=zstd"
    "zswap.max_pool_percent=20"
    "zswap.zpool=z3fold"
    "zswap.shrinker_enabled=1"
  ];
# boot.kernelPackages = pkgs.linuxPackages_zen;
  boot.kernelModules = [ "i2c-dev" "ddcci" ];
  boot.extraModulePackages = [ config.boot.kernelPackages.ddcci-driver ];
  boot.resumeDevice = "/dev/disk/by-uuid/a0e43e9e-2f26-4783-affc-970d69d4d4da";

  fileSystems = {
    "/".options = [ "compress=zstd" "noatime" ];
    "/home".options = [ "compress=zstd" "noatime" ];
    "/nix".options = [ "compress=zstd" "noatime" ];
  };

# zramSwap.enable = true;
  swapDevices = [{
    device = "/swap/swapfile";
    size  = 32*1024;
  }];
}
