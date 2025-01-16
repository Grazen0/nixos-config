{
  description = "My personal NixOS configurations";

  outputs = {
    flake-parts,
    nixpkgs,
    ...
  } @ inputs: let
    inherit (nixpkgs) lib;
    lib' = import ./lib {inherit lib inputs;};
  in
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = import inputs.systems;

      perSystem = {pkgs, ...}: {
        packages = import ./pkgs {inherit pkgs inputs;};
        devShells = import ./shell.nix {inherit pkgs;};
      };

      flake.nixosConfigurations = let
        inherit (lib') mkSystem;
      in {
        nitori = mkSystem {
          hostName = "nitori";
          system = "x86_64-linux";
        };

        takane = mkSystem {
          hostName = "takane";
          system = "x86_64-linux";
        };
      };
    };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-zoom.url = "github:NixOS/nixpkgs/bcb68885668cccec12276bbb379f8f2557aa06ce";

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

    hyprland-qtutils = {
      url = "github:hyprwm/hyprland-qtutils";
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

    kanagawa-rstudio = {
      url = "github:camartinezbu/kanagawa-rstudio";
      flake = false;
    };

    r-nvim = {
      url = "github:devOpifex/r.nvim";
      flake = false;
    };

    menu-qalc = {
      url = "github:ClemaX/menu-qalc-wayland";
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

    nvim-plugin-r-nvim = {
      url = "github:R-nvim/R.nvim";
      flake = false;
    };

    nvim-plugin-cmp-r = {
      url = "github:R-nvim/cmp-r";
      flake = false;
    };

    nvim-plugin-obsidian-bridge = {
      url = "github:oflisback/obsidian-bridge.nvim";
      flake = false;
    };

    grkstyle = {
      url = "github:gadenbuie/grkstyle";
      flake = false;
    };

    colorout = {
      url = "github:jalvesaq/colorout";
      flake = false;
    };

    inkscape-figures = {
      url = "github:gillescastel/inkscape-figures";
      flake = false;
    };

    mdformat-config = {
      url = "github:hukkin/mdformat-config";
      flake = false;
    };

    mdformat-ruff = {
      url = "github:Freed-Wu/mdformat-ruff";
      flake = false;
    };

    mdformat-web = {
      url = "github:hukkin/mdformat-web";
      flake = false;
    };

    mdformat-wikilink = {
      url = "github:tmr232/mdformat-wikilink";
      flake = false;
    };

    mdformat-obsidian = {
      url = "github:KyleKing/mdformat-obsidian";
      flake = false;
    };
  };
}
