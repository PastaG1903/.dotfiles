{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable } @ inputs: 

  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
    unstable = import nixpkgs-unstable {
      inherit system;
      config.allowUnfree = true;
    };
  in

  {

    nixosConfigurations.hermes = nixpkgs.lib.nixosSystem{
      inherit system;
      specialArgs = {
        inherit unstable inputs;
      };
      modules = [./configuration.nix ./hardware-configuration.nix];
    };

  };
}
