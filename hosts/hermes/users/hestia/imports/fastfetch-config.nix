{config, lib, pkgs, ...}:
{
  programs.fastfetch = {
    enable = true;

    settings = {
      "$schema" = "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json";

      logo = {
        source = "~/Desktop/full_vaps.png";
        width = 10;
      };

      modules = [
        "title"
          "separator"
          "os"
          "host"
          "kernel"
          "uptime"
          {
            type = "command";
            key = "Days alive";
            text = "echo $(($(date +%s)/86400 - $(stat -c %W /)/86400))";
          }
      "packages"
        "shell"
        "display"
        "de"
        "wm"
        "terminal"
        "terminalfont"
        "cpu"
        "gpu"
        "memory"
        "swap"
        "disk"
        "btrfs"
        "localip"
        "battery"
        "poweradapter"
        "break"
        "colors"
        ];
    };
  };

}
