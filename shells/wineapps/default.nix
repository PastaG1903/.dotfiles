{ pkgs }:
let
# Test run: no device flags, for validating Wine/GUI before hardware is involved
launchScript = pkgs.writeShellApplication {
  name = "wineapps";
  runtimeInputs = [ pkgs.podman ];
  text = ''
    CONTAINER_NAME="wineapps"
    WINDOWS_APPS_DIR="$HOME/WindowsApps"
    WINE_PREFIX_DIR="$HOME/.wineapps-prefix"

    mkdir -p "$WINDOWS_APPS_DIR"
    mkdir -p "$WINE_PREFIX_DIR"

    cleanup() {
      echo "Stopping container..."
        podman stop "$CONTAINER_NAME" 2>/dev/null || true
    }
  trap cleanup EXIT

    xhost +local: >/dev/null 2>&1 || true

    podman run --rm -it \
    --name "$CONTAINER_NAME" \
    --entrypoint bash \
    -e DISPLAY="$DISPLAY" \
    -e PULSE_SERVER="unix:/run/user/$(id -u)/pipewire-0" \
    -e WINEPREFIX=/home/wineuser/.wine \
    -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
    -v "/run/user/$(id -u)/pipewire-0:/run/user/$(id -u)/pipewire-0:rw" \
    -v "$WINDOWS_APPS_DIR:/home/wineuser/data:rw" \
    -v "$WINE_PREFIX_DIR:/home/wineuser/.wine:rw" \
    scottyhardy/docker-wine:stable
    '';
};
in
  pkgs.mkShell {
    name = "wineapps";
    buildInputs = [ pkgs.podman launchScript ];
    shellHook = ''
      wineapps && exit
      '';
  }
