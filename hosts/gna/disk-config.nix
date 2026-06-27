# Upon booting in a NixOS system, run the following (this assumes you have the disk-config.nix under /tmp):
# sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- -m destroy,format,mount /tmp/disk-config.nix
# You should add "${builtins.fetchTarball "https://github.com/nix-community/disko/archive/master.tar.gz"}/module.nix"
# as well as this very file as imports in configuration.nix
# Should there be questions, refer to https://github.com/nix-community/disko/blob/master/docs/quickstart.md 

{
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = "/dev/sda"; # change this accordingly
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              priority = 1;
              name = "ESP";
              # start = "1M";
              # end = "1024M";
              size = "1024M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "fmask=0022" "dmask=0022" ];
              };
            };
            root = {
              size = "100%";
              content = {
                type = "btrfs";
                # extraArgs = [ "-f" ]; # Override existing partition
                # Subvolumes must set a mountpoint in order to be mounted,
                # unless their parent is mounted
                subvolumes = {
                  # Subvolume name is different from mountpoint
                  "@" = {
                    mountpoint = "/";
                    mountOptions = [ "compress=zstd" "noatime" ];
                  };
                  # Subvolume name is the same as the mountpoint
                  "@home" = {
                    mountOptions = [ "compress=zstd" "noatime" ];
                    mountpoint = "/home";
                  };
                  # Sub(sub)volume doesn't need a mountpoint as its parent is mounted
                  # "/home/user" = { };
                  # Parent is not mounted so the mountpoint must be set
                  "@nix" = {
                    mountOptions = [ "compress=zstd" "noatime" ];
                    mountpoint = "/nix";
                  };
                  "@swap" = {
                    mountOptions = [ "noatime" ];
                    mountpoint = "/swap";
                  };
                  # This subvolume will be created but not mounted
                  # "/test" = { };
                  # Subvolume for the swapfile
                  # "/swap" = {
                  #   mountpoint = "/.swapvol";
                  #   swap = {
                  #     swapfile.size = "20M";
                  #     swapfile2.size = "20M";
                  #     swapfile2.path = "rel-path";
                  #   };
                  # };
                };
              };
            };
          };
        };
      };
    };
  };
}
