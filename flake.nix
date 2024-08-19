{
  description = "yeh";

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

    thorium-browser.url = "git+https://codeberg.org/Tomkoid/thorium-browser-nix";

    nix-matlab = {
      url = "gitlab:doronbehar/nix-matlab";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-stable,
    nixos-hardware,
    home-manager,
    nixvim,
    nix-matlab,
    ...
  } @ inputs: let
    inherit (self) outputs;
    system = "x86_64-linux";

    username = "jdgt";
    hosts = ["nitori" "takane"];

    specialArgs = {
      pkgs-stable = import nixpkgs-stable {
        inherit system;
        config.allowUnfree = true;
      };

      hardware = nixos-hardware.nixosModules;

      inherit inputs outputs username;
    };

    flake-overlays = [
      nix-matlab.overlay
    ];
  in {
    packages = nixpkgs.legacyPackages.${system};
    formatter = nixpkgs.legacyPackages.${system}.alejandra;

    nixosConfigurations = builtins.foldl' (acc: host:
      acc
      // {
        ${host} = nixpkgs.lib.nixosSystem {
          modules = [
            nixvim.nixosModules.nixvim
            (import ./shared/nixos/configuration.nix flake-overlays)
            ./hosts/${host}/nixos/configuration.nix
          ];

          specialArgs = specialArgs // {inherit host;};
        };
      }) {}
    hosts;

    homeConfigurations = builtins.foldl' (acc: host:
      acc
      // {
        "${username}@${host}" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${system};
          extraSpecialArgs = specialArgs // {inherit host;};
          modules = [
            ./shared/home-manager/home.nix
            ./hosts/${host}/home-manager/home.nix
          ];
        };
      }) {}
    hosts;
  };
}
