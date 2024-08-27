{
  description = "Configurations for my NixOS system";

  inputs = {
    nixpgkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";

    nixos-hardware.url = "github:nixos/nixos-hardware/master";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
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

    nix-matlab = {
      url = "gitlab:doronbehar/nix-matlab";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nixvim,
    ...
  } @ inputs: let
    inherit (self) outputs;

    forAllSystems = nixpkgs.lib.genAttrs [
      "aarch64-linux"
      "i686-linux"
      "x86_64-linux"
      "aarch64-darwin"
      "x86_64-darwin"
    ];

    username = "jdgt";
    hosts = ["nitori" "takane"];

    specialArgsPre = {
      inherit inputs outputs username;
    };
  in {
    packages = forAllSystems (system: import ./pkgs {pkgs = nixpkgs.legacyPackages.${system};});

    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

    overlays = import ./overlays {inherit inputs outputs;};

    devShells = forAllSystems (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};
      in
        import ./shell.nix {inherit pkgs;}
    );

    nixosModules = import ./modules/nixos;
    homeManagerModules = import ./modules/home-manager;

    nixosConfigurations = nixpkgs.lib.genAttrs hosts (
      host: let
        specialArgs = specialArgsPre // {inherit host;};
      in
        nixpkgs.lib.nixosSystem {
          modules = [./hosts/${host}/nixos/configuration.nix];

          specialArgs = specialArgs;
        }
    );
  };
}
