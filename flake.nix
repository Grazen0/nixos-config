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

    my_username = "jdgt";
    hosts = ["nitori" "takane"];

    specialArgs = {
      pkgs-stable = import nixpkgs-stable {
        inherit system;
        config.allowUnfree = true;
      };
      inherit inputs outputs;
    };
  in {
    nixosConfigurations = builtins.foldl' (acc: host:
      acc
      // {
        ${host} = nixpkgs.lib.nixosSystem {
          modules = [
            nixvim.nixosModules.nixvim
            ./hosts/${host}/nixos/configuration.nix
          ];

          inherit specialArgs;
        };
      }) {}
    hosts;

    homeConfigurations = builtins.foldl' (acc: host:
      acc
      // {
        "${my_username}@${host}" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${system};
          extraSpecialArgs = {inherit inputs outputs my_username;};
          modules = [./hosts/${host}/home-manager/home.nix];
        };
      }) {}
    hosts;
  };
}
