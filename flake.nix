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

    specialArgsPre = {
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
        ${host} = let
          specialArgs = specialArgsPre // {inherit host;};
        in
          nixpkgs.lib.nixosSystem {
            modules = [
              (import ./shared/nixos/configuration.nix flake-overlays)
              ./hosts/${host}/nixos/configuration.nix
              home-manager.nixosModules.home-manager
              nixvim.nixosModules.nixvim
              {
                home-manager = {
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  users.${username}.imports = [
                    ./shared/home-manager/home.nix
                    ./hosts/${host}/home-manager/home.nix
                  ];
                  extraSpecialArgs = specialArgs;
                };
              }
            ];

            specialArgs = specialArgs;
          };
      }) {}
    hosts;
  };
}
