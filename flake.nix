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
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-stable,
    nixos-hardware,
    home-manager,
    nixvim,
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
  in {
    nixosConfigurations = builtins.foldl' (acc: host:
      acc
      // {
        ${host} = nixpkgs.lib.nixosSystem {
          modules = [
            nixvim.nixosModules.nixvim
            ./shared/nixos/configuration.nix
            ./hosts/${host}/nixos/configuration.nix
            ./hosts/${host}/nixos/hardware-configuration.nix
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
