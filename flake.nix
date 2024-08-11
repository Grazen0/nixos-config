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

    specialArgs = {
      pkgs-stable = import nixpkgs-stable {
        inherit system;
        config.allowUnfree = true;
      };
      inherit inputs outputs;
    };

    host_main = "nitori";
    host_secondary = "takane";
  in {
    nixosConfigurations = {
      # My current laptop
      # ${host_main} = nixpkgs.lib.nixosSystem {
      #   modules = [
      #     nixvim.nixosModules.nixvim
      #     ./hosts/nitori/nixos/configuration.nix
      #   ];
      #
      #   inherit specialArgs;
      # };

      # My old laptop
      takane = nixpkgs.lib.nixosSystem {
        modules = [
          nixvim.nixosModules.nixvim
          ./hosts/takane/nixos/configuration.nix
        ];

        inherit specialArgs;
      };
    };

    homeConfigurations = {
      # "${host_main}@jdgt" = home-manager.lib.homeManagerConfiguration {
      #   pkgs = nixpkgs.legacyPackages.${system};
      #   extraSpecialArgs = {inherit inputs outputs;};
      #   modules = [./hosts/${host_main}/home-manager/home.nix];
      # };

      jdgt = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};
        extraSpecialArgs = {inherit inputs outputs;};
        modules = [./hosts/takane/home-manager/home.nix];
      };
    };
  };
}
