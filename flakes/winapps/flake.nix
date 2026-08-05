# flake.nix
{
  description = "Containerized Wine environment for 3D printing/servo/plotter apps";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };

      launchScript = pkgs.writeShellApplication {
        name = "wineapps";
        runtimeInputs = [ pkgs.podman ];
        text = ''
          CONTAINER_NAME="wineapps"

          cleanup() {
            echo "Stopping container..."
            podman stop "$CONTAINER_NAME" 2>/dev/null || true
          }
          trap cleanup EXIT

          xhost +local: >/dev/null 2>&1 || true

          podman run --rm -it \
            --entrypoint bash \
            --name "$CONTAINER_NAME" \
            -e DISPLAY="$DISPLAY" \
            -e PULSE_SERVER="unix:/run/user/$(id -u)/pipewire-0" \
            -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
            -v "/run/user/$(id -u)/pipewire-0:/run/user/$(id -u)/pipewire-0:rw" \
            -v "$HOME/WindowsApps:/home/wineuser/data:rw" \
            --group-add=keep-groups \
            scottyhardy/docker-wine:stable
        '';
      };

      # Variant with no device flags, for testing Wine/GUI before hardware is involved
      launchScriptNoDevices = pkgs.writeShellApplication {
        name = "wineapps-gui-only";
        runtimeInputs = [ pkgs.podman ];
        text = ''
          CONTAINER_NAME="wineapps-test"

          cleanup() {
            echo "Stopping container..."
            podman stop "$CONTAINER_NAME" 2>/dev/null || true
          }
          trap cleanup EXIT

          xhost +local: >/dev/null 2>&1 || true

          podman run --rm -it \
            --entrypoint bash \
            --name "$CONTAINER_NAME" \
            -e DISPLAY="$DISPLAY" \
            -e PULSE_SERVER="unix:/run/user/$(id -u)/pipewire-0" \
            -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
            -v "/run/user/$(id -u)/pipewire-0:/run/user/$(id -u)/pipewire-0:rw" \
            -v "$HOME/WindowsApps:/home/wineuser/data:rw" \
            scottyhardy/docker-wine:stable
        '';
      };
    in
    {
      apps.${system} = {
        default = {
          type = "app";
          program = "${launchScript}/bin/wineapps";
        };
        test = {
          type = "app";
          program = "${launchScriptNoDevices}/bin/wineapps-gui-only";
        };
      };

      devShells.${system}.default = pkgs.mkShell {
        buildInputs = [ pkgs.podman ];
        shellHook = ''
          echo "Commands available:"
          echo "  wineapps            - launch with device passthrough (printer/servo)"
          echo "  wineapps-gui-only   - launch without devices, for testing Wine/GUI first"
          export PATH="${launchScript}/bin:${launchScriptNoDevices}/bin:$PATH"
        '';
      };
    };
}
