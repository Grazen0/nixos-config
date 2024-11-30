{
  description = "My NixOS configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";

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
  };

  outputs = {
    flake-parts,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    inherit (nixpkgs) lib;
  in
    flake-parts.lib.mkFlake {inherit inputs;} (let
      hosts = lib.attrNames (lib.filterAttrs (_: type: type == "directory") (builtins.readDir ./hosts));
      theme = import ./theme.nix {inherit lib;};
    in {
      systems = ["x86_64-linux"];

      perSystem = {pkgs, ...}: {
        devShells = import ./shell.nix {inherit pkgs;};
      };

      flake = {
        overlays = import ./overlays {inherit inputs;};

        nixosConfigurations = lib.genAttrs hosts (host:
          lib.nixosSystem {
            modules = [
              ./modules/nixos
              ./hosts/${host}/nixos/configuration.nix
            ];
            specialArgs = {inherit inputs theme;};
          });

        homeConfigurations = lib.listToAttrs (lib.map (host: {
            name = "jdgt@${host}";
            value = home-manager.lib.homeManagerConfiguration {
              pkgs = nixpkgs.legacyPackages.x86_64-linux;
              modules = [
                ./hosts/${host}/home-manager/home.nix
                ./modules/home-manager
              ];
              extraSpecialArgs = {inherit inputs theme;};
            };
          })
          hosts);
      };
    });
}
