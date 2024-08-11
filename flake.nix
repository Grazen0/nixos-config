{
  description = "yeh";

  inputs = {
    nixpgkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-stable,
    home-manager,
    nixvim,
    ...
  } @ inputs: let
    inherit (self) outputs;
    system = "x86_64-linux";
  in {
    nixosConfigurations.takane = nixpkgs.lib.nixosSystem {
      specialArgs = {
        pkgs-stable = import nixpkgs-stable {
          inherit system;
          config.allowUnfree = true;
        };
        inherit inputs outputs;
      };
      modules = [
        nixvim.nixosModules.nixvim
        ./nixos/configuration.nix
      ];
    };

    homeConfigurations.jdgt = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.${system};
      extraSpecialArgs = {inherit inputs outputs;};
      modules = [./home-manager/home.nix];
    };
  };
}
