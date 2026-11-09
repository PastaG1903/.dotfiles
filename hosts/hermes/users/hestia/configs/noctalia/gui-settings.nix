# Noctalia settings, mirrored from the GUI by the dmopp/settings-to-nix plugin
# (/home/hestia/.local/state/noctalia/settings.toml). Every export overwrites this file.
#
# This file is your backup: keep it somewhere safe, for example in git.
#
# To restore, run this as your user in the directory of this file:
#   $(nix-build --no-out-link ./gui-settings.nix)/bin/noctalia-restore-settings
# It replaces settings.toml (the old one is kept as settings.toml.bak-<time>).
# Then restart Noctalia; it installs the plugins listed here again on startup.
{ pkgs ? import <nixpkgs> { } }:
let
  settings = {
    backdrop = {
      blur_intensity = 0.099999997764825821;
      enabled = true;
      tint_intensity = 0.0;
    };
    bar.default = {
      border = "primary";
      border_width = 5.0;
      center = [ "active_window" "keyd" "charge-once" "bar_2" ];
      end = [
        "workspaces"
        "network"
        "bluetooth"
        "volume"
        "X-Monitor-Brightness"
        "brightness"
        "notifications"
        "clipboard"
        "tray"
        "keyboard_layout"
        "battery"
        "caffeine"
        "widget_2"
        "session"
      ];
      margin_ends = 0;
      padding = 15;
      start = [ "launcher" "clock" "bar" "summary" "bar_3" ];
      thickness = 35;
      widget_spacing = 10;
    };
    battery.warning_threshold = 20;
    brightness = {
      enable_ddcutil = true;
      sync_all_monitors = true;
    };
    calendar = {
      account.tec_calendar = {
        color = "tertiary";
        name = "Tec Calendar";
        type = "google";
      };
      enabled = true;
      refresh_minutes = 5;
    };
    config_version = 16;
    control_center = {
      calendar.show_week_numbers = true;
      shortcuts = [
        {
          type = "wifi";
        }
        {
          type = "bluetooth";
        }
        {
          type = "caffeine";
        }
        {
          type = "notification";
        }
        {
          type = "power_profile";
        }
        {
          type = "wallpaper";
        }
      ];
      sidebar = "full";
      width = 880;
    };
    desktop_widgets = {
      grid = {
        cell_size = 16;
        major_interval = 4;
        visible = true;
      };
      schema_version = 2;
      widget = {
        desktop-widget-0000000000000002 = {
          box_height = 160.0;
          box_width = 288.0;
          cx = 208.0;
          cy = 184.0;
          output = "eDP-1";
          placement_height = 1200.0;
          placement_width = 1920.0;
          rotation = 0.0;
          settings = {
            background = true;
            background_color = "surface_container";
            background_opacity = 0.0;
            center_text = true;
            color = "secondary";
            font_family = "Miracode";
            format = "{:%d-%m-%y\\n%H:%M}";
          };
          type = "clock";
        };
        desktop-widget-0000000000000003 = {
          box_height = 160.0;
          box_width = 128.0;
          cx = 128.0;
          cy = 377.0;
          output = "eDP-1";
          placement_height = 1200.0;
          placement_width = 1920.0;
          rotation = 0.0;
          settings = {
            background_color = "surface_container";
            background_opacity = 0.10000000000000001;
            color = "secondary";
            display = "gauge";
            gauge_layout = "vertical";
            stat = "cpu_usage";
            stat2 = "cpu_temp";
          };
          type = "sysmon";
        };
        desktop-widget-0000000000000004 = {
          box_height = 160.0;
          box_width = 128.0;
          cx = 288.0;
          cy = 377.0;
          output = "eDP-1";
          placement_height = 1200.0;
          placement_width = 1920.0;
          rotation = 0.0;
          settings = {
            background_color = "surface_container";
            background_opacity = 0.10000000000000001;
            color = "secondary";
            display = "gauge";
            gauge_layout = "vertical";
            stat = "cpu_temp";
            stat2 = "cpu_temp";
          };
          type = "sysmon";
        };
        desktop-widget-0000000000000005 = {
          box_height = 160.0;
          box_width = 128.0;
          cx = 128.0;
          cy = 568.0;
          output = "eDP-1";
          placement_height = 1200.0;
          placement_width = 1920.0;
          rotation = 0.0;
          settings = {
            background_color = "surface_container";
            background_opacity = 0.10000000000000001;
            color = "secondary";
            display = "gauge";
            gauge_layout = "vertical";
            stat = "ram_pct";
            stat2 = "cpu_temp";
          };
          type = "sysmon";
        };
        desktop-widget-0000000000000006 = {
          box_height = 160.0;
          box_width = 128.0;
          cx = 288.0;
          cy = 568.0;
          output = "eDP-1";
          placement_height = 1200.0;
          placement_width = 1920.0;
          rotation = 0.0;
          settings = {
            background_color = "surface_container";
            background_opacity = 0.10000000000000001;
            color = "secondary";
            display = "gauge";
            gauge_layout = "vertical";
            stat = "swap_pct";
            stat2 = "cpu_temp";
          };
          type = "sysmon";
        };
        desktop-widget-0000000000000007 = {
          box_height = 160.0;
          box_width = 288.0;
          cx = 224.0;
          cy = 171.0;
          output = "DP-2";
          placement_height = 1080.0;
          placement_width = 1920.0;
          rotation = 0.0;
          settings = {
            background = true;
            background_color = "surface_container";
            background_opacity = 0.0;
            center_text = true;
            color = "secondary";
            font_family = "Miracode";
            format = "{:%d-%m-%y\\n%H:%M}";
          };
          type = "clock";
        };
        desktop-widget-0000000000000008 = {
          box_height = 160.0;
          box_width = 128.0;
          cx = 144.0;
          cy = 364.0;
          output = "DP-2";
          placement_height = 1080.0;
          placement_width = 1920.0;
          rotation = 0.0;
          settings = {
            background_color = "surface_container";
            background_opacity = 0.10000000000000001;
            color = "secondary";
            display = "gauge";
            gauge_layout = "vertical";
            stat = "cpu_usage";
            stat2 = "cpu_temp";
          };
          type = "sysmon";
        };
        desktop-widget-0000000000000009 = {
          box_height = 160.0;
          box_width = 128.0;
          cx = 304.0;
          cy = 364.0;
          output = "DP-2";
          placement_height = 1080.0;
          placement_width = 1920.0;
          rotation = 0.0;
          settings = {
            background_color = "surface_container";
            background_opacity = 0.10000000000000001;
            color = "secondary";
            display = "gauge";
            gauge_layout = "vertical";
            stat = "cpu_temp";
            stat2 = "cpu_temp";
          };
          type = "sysmon";
        };
        desktop-widget-000000000000000a = {
          box_height = 160.0;
          box_width = 128.0;
          cx = 144.0;
          cy = 555.0;
          output = "DP-2";
          placement_height = 1080.0;
          placement_width = 1920.0;
          rotation = 0.0;
          settings = {
            background_color = "surface_container";
            background_opacity = 0.10000000000000001;
            color = "secondary";
            display = "gauge";
            gauge_layout = "vertical";
            stat = "ram_pct";
            stat2 = "cpu_temp";
          };
          type = "sysmon";
        };
        desktop-widget-000000000000000b = {
          box_height = 160.0;
          box_width = 128.0;
          cx = 304.0;
          cy = 555.0;
          output = "DP-2";
          placement_height = 1080.0;
          placement_width = 1920.0;
          rotation = 0.0;
          settings = {
            background_color = "surface_container";
            background_opacity = 0.10000000000000001;
            color = "secondary";
            display = "gauge";
            gauge_layout = "vertical";
            stat = "swap_pct";
            stat2 = "cpu_temp";
          };
          type = "sysmon";
        };
        desktop-widget-000000000000000c = {
          box_height = 352.0;
          box_width = 432.0;
          cx = 444.0;
          cy = 399.60003662109375;
          output = "HDMI-A-1";
          placement_height = 1080.0;
          placement_width = 1920.0;
          rotation = 0.0;
          settings = {
            background = true;
            background_color = "surface_container";
            background_opacity = 0.0;
            center_text = true;
            color = "secondary";
            font_family = "Miracode";
            format = "{:%d-%m-%y\\n%H:%M}";
          };
          type = "clock";
        };
        desktop-widget-000000000000000d = {
          box_height = 472.93359375;
          box_width = 735.1875;
          cx = 1474.15625;
          cy = 345.892578125;
          output = "eDP-1";
          placement_height = 1200.0;
          placement_width = 1920.0;
          rotation = 0.0;
          settings = {
            background = true;
            background_color = "surface";
            background_opacity = 0.40000000000000002;
            background_padding = 15;
            background_radius = 12;
            font_family = "";
            show_events = true;
            show_week_numbers = true;
          };
          type = "calendar";
        };
        desktop-widget-000000000000000e = {
          box_height = 472.93359375;
          box_width = 735.1875;
          cx = 1490.15625;
          cy = 361.892578125;
          output = "DP-2";
          placement_height = 1080.0;
          placement_width = 1920.0;
          rotation = 0.0;
          settings = {
            background = true;
            background_color = "surface";
            background_opacity = 0.40000000000000002;
            background_padding = 15;
            background_radius = 12;
            font_family = "";
            show_events = true;
            show_week_numbers = true;
          };
          type = "calendar";
        };
      };
      widget_order = [
        "desktop-widget-0000000000000002"
        "desktop-widget-0000000000000003"
        "desktop-widget-0000000000000004"
        "desktop-widget-0000000000000005"
        "desktop-widget-0000000000000006"
        "desktop-widget-0000000000000007"
        "desktop-widget-0000000000000008"
        "desktop-widget-0000000000000009"
        "desktop-widget-000000000000000a"
        "desktop-widget-000000000000000b"
        "desktop-widget-000000000000000c"
        "desktop-widget-000000000000000d"
        "desktop-widget-000000000000000e"
      ];
    };
    dock = {
      active_monitor_only = true;
      auto_hide = true;
      background_opacity = 0.79999998211860657;
      enabled = true;
      launcher_icon = "rocket";
      launcher_position = "start";
      magnification_scale = 1.5000000074505806;
      pinned = [ "org.gnome.Nautilus" ];
      reserve_space = false;
      show_dots = true;
    };
    idle = {
      behavior = {
        lock = {
          action = "lock";
          enabled = true;
          timeout = 600.0;
        };
        lock-and-suspend = {
          action = "lock_and_suspend";
          enabled = true;
          timeout = 900.0;
        };
        screen-off = {
          action = "screen_off";
          enabled = true;
          timeout = 300.0;
        };
      };
      behavior_order = [ "screen-off" "lock" "lock-and-suspend" ];
      pre_action_fade_seconds = 10;
    };
    keybinds = {
      cancel = [ "Escape" ];
      validate = [ "Return" "KP_Enter" ];
    };
    location.auto_locate = true;
    lockscreen_widgets = {
      enabled = true;
      grid = {
        cell_size = 16;
        major_interval = 4;
        visible = true;
      };
      schema_version = 2;
      widget = {
        "lockscreen-login-box@DP-2" = {
          box_height = 196.0;
          box_width = 810.0;
          cx = 960.0;
          cy = 881.5;
          output = "DP-2";
          placement_height = 1080.0;
          placement_width = 1920.0;
          rotation = 0.0;
          settings = {
            background_color = "surface_container";
            background_opacity = 0.88;
            background_radius = 12.0;
            center_password_text = false;
            input_opacity = 1.0;
            input_radius = 6.0;
            layout = "regular";
            show_caps_lock = true;
            show_keyboard_layout = true;
            show_login_button = true;
            show_media = true;
            show_session_buttons = true;
            show_unlock_hint = true;
            show_weather = true;
          };
          type = "login_box";
        };
        "lockscreen-login-box@HDMI-A-1" = {
          box_height = 196.0;
          box_width = 810.0;
          cx = 1440.0;
          cy = 1080.0;
          output = "HDMI-A-1";
          placement_height = 1080.0;
          placement_width = 1920.0;
          rotation = 0.0;
          settings = {
            background_color = "surface_container";
            background_opacity = 0.88;
            background_radius = 12.0;
            center_password_text = false;
            input_opacity = 1.0;
            input_radius = 6.0;
            layout = "regular";
            show_caps_lock = true;
            show_keyboard_layout = true;
            show_login_button = true;
            show_media = true;
            show_session_buttons = true;
            show_unlock_hint = true;
            show_weather = true;
          };
          type = "login_box";
        };
        "lockscreen-login-box@eDP-1" = {
          box_height = 196.0;
          box_width = 810.0;
          cx = 960.0;
          cy = 1001.5;
          output = "eDP-1";
          placement_height = 1200.0;
          placement_width = 1920.0;
          rotation = 0.0;
          settings = {
            background_color = "surface_container";
            background_opacity = 0.88;
            background_radius = 12.0;
            center_password_text = true;
            input_opacity = 1.0;
            input_radius = 6.0;
            layout = "regular";
            show_caps_lock = true;
            show_keyboard_layout = true;
            show_login_button = true;
            show_media = true;
            show_session_buttons = true;
            show_unlock_hint = true;
            show_weather = true;
          };
          type = "login_box";
        };
        lockscreen-widget-0000000000000001 = {
          box_height = 256.0;
          box_width = 256.0;
          cx = 960.0;
          cy = 664.0;
          output = "eDP-1";
          placement_height = 1200.0;
          placement_width = 1920.0;
          rotation = 0.0;
          settings.clock_style = "analog";
          type = "clock";
        };
        lockscreen-widget-0000000000000002 = {
          box_height = 256.0;
          box_width = 256.0;
          cx = 960.0;
          cy = 540.0;
          output = "DP-2";
          placement_height = 1080.0;
          placement_width = 1920.0;
          rotation = 0.0;
          settings.clock_style = "analog";
          type = "clock";
        };
      };
      widget_order = [
        "lockscreen-login-box@HDMI-A-1"
        "lockscreen-login-box@eDP-1"
        "lockscreen-login-box@DP-2"
        "lockscreen-widget-0000000000000001"
        "lockscreen-widget-0000000000000002"
      ];
    };
    plugin_settings = {
      "ahmedhossamdev/sticky-notes" = {
        default_color = "blue";
        panel_placement = "floating";
        use_wallpaper_colors = true;
      };
      "ashur-d/nvim-projects".projects_dir = "/home/hestia/Documents";
      "dmopp/settings-to-nix".target_path = "/home/hestia/.config/noctalia/gui-settings.nix";
      "gustav0ar/drive-health".system_collector_enabled = true;
    };
    plugins.enabled = [
      "nightwatch75/file-search"
      "gustav0ar/drive-health"
      "noctalia/world_clock"
      "cleboost/ssh-launcher"
      "ahmedhossamdev/sticky-notes"
      "alexander/screen-toolkit"
      "rylos/usb-manager"
      "ashur-d/nvim-projects"
      "yahya637/process-monitor"
      "dmopp/settings-to-nix"
    ];
    shell = {
      font_family = "Miracode";
      niri_overview_type_to_launch_enabled = true;
      polkit_agent = true;
    };
    theme = {
      builtin = "Noctalia";
      community_palette = "Oxocarbon";
      source = "wallpaper";
      templates = {
        builtin_ids = [ "btop" "gtk3" "gtk4" "kitty" "niri" "qt" ];
        community_ids = [ "neovim" "vicinae" "lazygit" "yazi" ];
      };
      wallpaper_scheme = "vibrant";
    };
    wallpaper = {
      automation = {
        enabled = true;
        interval_seconds = 120;
        order = "alphabetical";
        recursive = false;
      };
      directory = "/home/hestia/Desktop/wallpapers";
      fill_color = "secondary";
      transition_on_startup = true;
    };
    widget = {
      X-Monitor-Brightness = {
        actions = {
          left = "exec busctl --user set-property rs.wl-gammarelay /outputs/DP_2 rs.wl.gammarelay Brightness d 0.725";
          middle = "exec busctl --user set-property rs.wl-gammarelay /outputs/DP_2 rs.wl.gammarelay Brightness d 1";
          right = "exec busctl --user set-property rs.wl-gammarelay /outputs/DP_2 rs.wl.gammarelay Brightness d 0.875";
        };
        glyph = "brightness-2";
        type = "custom_button";
      };
      bar.type = "noctalia/world_clock:bar";
      bar_2.type = "ahmedhossamdev/sticky-notes:bar";
      bar_3 = {
        display = "totals";
        type = "yahya637/process-monitor:bar";
      };
      charge-once = {
        actions.left = "exec pkexec tlp chargeonce";
        glyph = "battery-charging";
        type = "custom_button";
      };
      clock.format = "{:%H:%M | %d-%m-%Y}";
      keyd = {
        actions = {
          left = "exec pkexec systemctl start keyd";
          right = "exec pkexec systemctl stop keyd";
        };
        glyph = "keyboard-hide";
        type = "custom_button";
      };
      launcher.glyph = "rocket";
      summary.type = "gustav0ar/drive-health:summary";
      sysmon.stat = "cpu_temp";
      widget_2.type = "alexander/screen-toolkit:widget";
    };
  };
  settingsToml = (pkgs.formats.toml { }).generate "noctalia-settings.toml" settings;
in
(pkgs.writeShellScriptBin "noctalia-restore-settings" ''
  set -eu
  PATH=${pkgs.coreutils}/bin:$PATH
  if [ -n "''${NOCTALIA_STATE_HOME:-}" ]; then
    dir="$NOCTALIA_STATE_HOME/noctalia"
  elif [ -n "''${XDG_STATE_HOME:-}" ]; then
    dir="$XDG_STATE_HOME/noctalia"
  else
    dir="$HOME/.local/state/noctalia"
  fi
  mkdir -p "$dir"
  if [ -e "$dir/settings.toml" ]; then
    backup="$dir/settings.toml.bak-$(date +%Y%m%d-%H%M%S)"
    cp "$dir/settings.toml" "$backup"
    echo "Previous settings saved to $backup"
  fi
  tmp=$(mktemp "$dir/.settings.toml.XXXXXX")
  cat ${settingsToml} > "$tmp"
  chmod 644 "$tmp"
  mv "$tmp" "$dir/settings.toml"
  # Skip the first-run wizard; it would write its own choices over the restored ones.
  touch "$dir/.setup-complete"
  echo "Noctalia settings restored to $dir/settings.toml."
  echo "Restart Noctalia so it installs the plugins from the restored settings."
'') // { inherit settings; }
