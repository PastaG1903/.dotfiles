{
  description = "Flake for global configuration and home manager";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs-static.url = "github:NixOS/nixpkgs/62792026d8b0812da03459aadc5b4163d23e9371";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    noctalia = {
        url = "github:noctalia-dev/noctalia";
        inputs.nixpkgs.follows = "nixpkgs";
    };
    noctalia-greeter = {
      url = "github:noctalia-dev/noctalia-greeter";
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
    homeConfigurations.shay = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = {
        inherit inputs unstable static;
      };
      modules = [
        ./hosts/gna/users/shay/home.nix
      ];
    };
  };
}
