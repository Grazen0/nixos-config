{
  description = "My personal NixOS configurations";

  outputs =
    {
      self,
      flake-parts,
      nixpkgs,
      ...
    }@inputs:
    let
      inherit (nixpkgs) lib;
      moduleArgs = { inherit lib' inputs; };
      lib' = import ./lib (moduleArgs // { inherit lib; });
    in
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];

      flake.nixosConfigurations = import ./hosts moduleArgs;

      perSystem =
        { pkgs, ... }:
        let
          systemModuleArgs = moduleArgs // {
            inherit pkgs;
          };
        in
        {
          packages = import ./pkgs systemModuleArgs;
          devShells = import ./shell.nix systemModuleArgs;
        };
    };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.05";

    flake-parts.url = "github:hercules-ci/flake-parts";
    nixos-hardware.url = "github:nixos/nixos-hardware/master";

    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay/3cf910c2727eed304b8aabcfddc109e0c0371bfb";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    base16.url = "github:SenchoPens/base16.nix";

    tt-schemes = {
      url = "github:tinted-theming/schemes";
      flake = false;
    };

    base16-zathura = {
      url = "github:haozeke/base16-zathura";
      flake = false;
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ppick = {
      url = "github:Grazen0/ppick";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plates = {
      url = "github:Grazen0/plates";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
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

    yazi.url = "github:sxyazi/yazi";

    yazi-plugins = {
      url = "github:yazi-rs/plugins";
      flake = false;
    };

    yazi-plugin-restore = {
      url = "github:boydaihungst/restore.yazi";
      flake = false;
    };

    menu-qalc = {
      url = "github:Grazen0/menu-qalc-wayland";
      flake = false;
    };

    river-shifttags = {
      url = "gitlab:Grazen0/river-shifttags";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    colorout = {
      url = "github:jalvesaq/colorout";
      flake = false;
    };

    ristate = {
      url = "github:ViniciusSSilva/ristate";
      flake = false;
    };
  };

  nixConfig = {
    extra-substituters = [ "https://yazi.cachix.org" ];
    extra-trusted-public-keys = [ "yazi.cachix.org-1:Dcdz63NZKfvUCbDGngQDAZq6kOroIrFoyO064uvLh8k=" ];
  };
}
