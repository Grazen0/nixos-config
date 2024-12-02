{
  description = "My NixOS configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";

    systems.url = "github:nix-systems/default-linux";

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:nixos/nixos-hardware/master";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:MarceColl/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    thorium-browser = {
      url = "git+https://codeberg.org/Tomkoid/thorium-browser-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    aphrodite-terminal-theme = {
      url = "github:win0err/aphrodite-terminal-theme";
      flake = false;
    };

    yazi-flavor-kanagawa = {
      url = "github:dangooddd/kanagawa.yazi";
      flake = false;
    };

    yazi-plugins = {
      url = "github:yazi-rs/plugins";
      flake = false;
    };

    yazi-plugin-relative-motions = {
      url = "github:dedukun/relative-motions.yazi/0.3.3";
      flake = false;
    };

    nvim-plugin-multicursor = {
      url = "github:jake-stewart/multicursor.nvim";
      flake = false;
    };

    nvim-plugin-live-share = {
      url = "github:azratul/live-share.nvim";
      flake = false;
    };

    menu-qalc = {
      url = "github:ClemaX/menu-qalc-wayland";
      flake = false;
    };

    inkscape-figures = {
      url = "github:gillescastel/inkscape-figures";
      flake = false;
    };
  };

  outputs = {
    self,
    flake-parts,
    nixpkgs,
    nixpkgs-stable,
    home-manager,
    ...
  } @ inputs: let
    inherit (nixpkgs) lib;
  in
    flake-parts.lib.mkFlake {inherit inputs;} (let
      hosts = lib.attrNames (lib.filterAttrs (_: type: type == "directory") (builtins.readDir ./hosts));

      stablePkgsFor = system:
        import nixpkgs-stable {
          inherit system;
          config.allowUnfree = true;
        };

      customPkgsFor = pkgs: import ./pkgs {inherit pkgs inputs;};
    in {
      systems = import inputs.systems;

      perSystem = {pkgs, ...}: {
        packages = customPkgsFor pkgs;
        devShells = import ./shell.nix {inherit pkgs;};
      };

      flake = {
        nixosConfigurations = let
          mkSystem = {
            hostname,
            system,
          }:
            lib.nixosSystem {
              modules = [
                ./modules/nixos
                ./modules/common
                ./hosts/${hostname}/nixos/configuration.nix
              ];

              specialArgs = {
                inherit inputs;
                stablePkgs = stablePkgsFor system;
                customPkgs = self.packages.${system};
              };
            };
        in {
          nitori = mkSystem {
            hostname = "nitori";
            system = "x86_64-linux";
          };

          takane = mkSystem {
            hostname = "takane";
            system = "x86_64-linux";
          };
        };

        homeConfigurations = lib.listToAttrs (lib.map (host: {
            name = "jdgt@${host}";
            value = home-manager.lib.homeManagerConfiguration {
              pkgs = nixpkgs.legacyPackages.x86_64-linux;
              modules = [
                ./modules/home-manager
                ./modules/common
                ./hosts/${host}/home-manager/home.nix
              ];
              extraSpecialArgs = {
                inherit inputs;
                stablePkgs = stablePkgsFor "x86_64-linux";
                customPkgs = customPkgsFor nixpkgs.legacyPackages.x86_64-linux;
              };
            };
          })
          hosts);
      };
    });
}
