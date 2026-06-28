{
  description = "Flake for global configuration and home manager";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs-static.url = "github:NixOS/nixpkgs/b94b5749679a8ec1daea5e6c0a2a4f9466f2e7c2";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, nixpkgs-static, home-manager, ... } @ inputs: 

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
  static = import nixpkgs-static {
    inherit system;
    config.allowUnfree = true;
  };

  in

  {
    nixosConfigurations.hermes = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {
        inherit inputs unstable static;
      };
      modules = [ ./hosts/hermes/configuration.nix ];
    };

    nixosConfigurations.gna = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {
        inherit inputs unstable static;
      };
      modules = [ ./hosts/gna/configuration.nix ];
    };

    nixosConfigurations.ludovico = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {
        inherit inputs unstable static;
      };
      modules = [ ./hosts/ludovico/configuration.nix ];
    };

    homeConfigurations.hestia = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = {
        inherit inputs unstable static;
      };
      modules = [
        ./hosts/hermes/users/hestia/home.nix
      ];
    };
  };
}
