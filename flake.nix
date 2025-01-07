{
  description = "Noel's dotfiles configuration for my devices that run NixOS";

  # Include the binary caches for my own projects and Noelware's as well.
  nixConfig = {
    extra-substituters = [
      # TODO: switch to https://nix.floofy.dev
      "https://noel.cachix.org"

      # TODO: switch to https://nix.noelware.org
      "https://noelware.cachix.org"
    ];

    extra-trusted-public-keys = [
      "noel.cachix.org-1:pQHbMJOB5h5VqYi3RV0Vv0EaeHfxARxgOhE9j013XwQ="
      "noelware.cachix.org-1:22A8ELRjkqEycSHz+R5A5ReX2jyjU3rftsBmlD6thn0="
    ];
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    hardware.url = "github:NixOS/nixos-hardware";
    systems.url = "github:nix-systems/default";

    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # noelware = {
    #   url = "github:Noelware/nixpkgs-noelware";
    #   inputs = {
    #     nixpkgs.follows = "nixpkgs";
    #     systems.follows = "systems";
    #   };
    # };

    # noel = {
    #   url = "github:auguwu/nixpkgs-overlay";
    #   inputs = {
    #     nixpkgs.follows = "nixpkgs";
    #     systems.follows = "systems";
    #   };
    # };
  };

  outputs = {
    nixpkgs,
    systems,
    hardware,
    ...
  } @ inputs: let
    eachSystem = nixpkgs.lib.genAttrs (import systems);
    overlays = [
      # noelware.overlays.default
      # noel.overlays.default
    ];

    mkSystem = import ./lib/mkSystem.nix {
      inherit nixpkgs inputs overlays;
    };

    nixpkgsFor = system:
      import nixpkgs {
        inherit system;
      };
  in {
    formatter = eachSystem (system: (nixpkgsFor system).alejandra);
    nixosConfigurations = {
      floofbox = mkSystem "floofbox" {
        system = "x86_64-linux";
        modules = [
          hardware.nixosModules.common-cpu-amd
          hardware.nixosModules.common-gpu-amd
        ];
      };

      kotoha = mkSystem "kotoha" {
        system = "x86_64-linux";
        modules = [
          hardware.nixosModules.framework-13-7040-amd
        ];
      };
    };

    darwinConfigurations = {
      miki = mkSystem "miki" {
        system = "aarch64-darwin";
        darwin = true;
      };
    };
  };
}
