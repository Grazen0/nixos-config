{
  description = "My personal NixOS configurations";

  outputs = {
    flake-parts,
    nixpkgs,
    ...
  } @ inputs: let
    inherit (nixpkgs) lib;
    moduleArgs = {inherit lib' inputs;};
    lib' = import ./lib (moduleArgs // {inherit lib;});
  in
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = import inputs.systems;

      perSystem = {pkgs, ...}: let
        systemModuleArgs = moduleArgs // {inherit pkgs;};
      in {
        packages = import ./pkgs systemModuleArgs;
        devShells = import ./shell.nix systemModuleArgs;
      };

      flake.nixosConfigurations = import ./hosts moduleArgs;
    };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-zoom.url = "github:NixOS/nixpkgs/bcb68885668cccec12276bbb379f8f2557aa06ce";

    flake-parts.url = "github:hercules-ci/flake-parts";
    systems.url = "github:nix-systems/default-linux";
    nixos-hardware.url = "github:nixos/nixos-hardware/master";

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    haskell-debug-adapter = {
      url = "github:phoityne/haskell-debug-adapter/8f31926595109ade331b6c314d862e0d00a5734a";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ppick = {
      url = "github:Grazen0/ppick";
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

    kanagawa-rstudio = {
      url = "github:camartinezbu/kanagawa-rstudio";
      flake = false;
    };

    r-nvim = {
      url = "github:devOpifex/r.nvim";
      flake = false;
    };

    menu-qalc = {
      url = "github:Grazen0/menu-qalc-wayland";
      flake = false;
    };

    fnott = {
      url = "git+https://codeberg.org/Grazen0/fnott";
      flake = false;
    };

    river-shifttags = {
      url = "gitlab:Grazen0/river-shifttags";
      inputs.nixpkgs.follows = "nixpkgs";
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
      url = "github:R-nvim/R.nvim/6d3000fe41d891e4bf9f905578828a910f893c6f";
      flake = false;
    };

    nvim-plugin-obsidian-bridge = {
      url = "github:oflisback/obsidian-bridge.nvim";
      flake = false;
    };

    nvim-plugin-luasnip-latex-snippets = {
      url = "github:iurimateus/luasnip-latex-snippets.nvim";
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

    mopidy-discord-rpc = {
      url = "github:very-amused/mopidy-discord-rpc";
      flake = false;
    };

    tmux-plugin-kanagawa = {
      url = "github:Nybkox/tmux-kanagawa";
      flake = false;
    };

    yazi-plugin-restore = {
      url = "github:boydaihungst/restore.yazi";
      flake = false;
    };
  };
}
