{
  description = "Noel 🌺's .dotfiles configuration";
  nixConfig = {
    extra-substituters = [
      "https://noel.cachix.org"
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

    vscode-server = {
      url = "github:nix-community/nixos-vscode-server";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # ume = {
    #   url = "github:auguwu/ume/4.0.5";
    #   inputs = {
    #     nixpkgs.follows = "nixpkgs";
    #   };
    # };

    # noeldoc = {
    #   url = "github:noeldoc-build/noeldoc/0.1.0";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    # charted = {
    #   url = "github:charted-dev/charted/0.1.0";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };

  outputs = {
    nixpkgs,
    home-manager,
    vscode-server,
    #ume,
    hardware,
    systems,
    darwin,
    ...
  }: let
    eachSystem = nixpkgs.lib.genAttrs (import systems);
    nixpkgsFor = system:
      import nixpkgs {
        inherit system;
      };

    mkDarwinSystem = name: {
      modules ? [],
      graphical ? true,
    }: let
      modules' =
        modules
        ++ [
          home-manager.darwinModules.home-manager

          ./hosts/${name}/configuration.nix

          {
            home-manager = {
              useUserPackages = true;
              useGlobalPkgs = true;
              users.noel = import ./users/noel/home.nix;
              extraSpecialArgs = {
                inherit graphical;

                machine = name;
              };
            };
          }
        ];
    in
      darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = modules';
      };

    mkNixSystem = name: {
      system,
      graphical ? false,
      modules ? [],
    }: let
      modules' =
        modules
        ++ [
          home-manager.nixosModules.home-manager
          vscode-server.nixosModules.default

          ./hosts/${name}/configuration.nix

          {
            home-manager = {
              useUserPackages = true;
              useGlobalPkgs = true;
              users.noel = import ./users/noel/home.nix;
              extraSpecialArgs = {
                inherit graphical;
                machine = name;
              };
            };
          }
        ];
    in
      nixpkgs.lib.nixosSystem {
        inherit system;

        modules = modules';
      };
  in {
    formatter = eachSystem (system: (nixpkgsFor system).alejandra);
    homeConfigurations."noel" = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgsFor builtins.currentSystem;
      modules = [./users/noel/home.nix];
    };

    nixosConfigurations = {
      # `floofbox`: main workstation
      floofbox = mkNixSystem "floofbox" rec {
        graphical = true;
        system = "x86_64-linux";
        modules = [
          hardware.nixosModules.common-cpu-amd
          hardware.nixosModules.common-gpu-amd

          {
            environment.systemPackages = [
              # ume.packages.${system}.ume

              # noeldoc.packages.${system}.noeldoc
              # charted.packages.${system}.helm-plugin
            ];
          }
        ];
      };

      # `kotoha`: Framework 13 Laptop
      kotoha = mkNixSystem "kotoha" rec {
        graphical = true;
        system = "x86_64-linux";
        modules = [
          hardware.nixosModules.framework-13-7040-amd
          {
            environment.systemPackages = [
              # ume.packages.${system}.ume

              # noeldoc.packages.${system}.noeldoc
              # charted.packages.${system}.helm-plugin
            ];
          }
        ];
      };
    };

    darwinConfigurations = {
      # `miki`: Home-server Mac Mini
      miki = mkDarwinSystem "miki" {
        modules = [
          {
            environment.systemPackages = [
              # ume.packages.aarch64-darwin.ume
            ];
          }
        ];
      };
    };
  };
}
