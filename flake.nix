{
  description = "yeh";

  inputs = {
    nixpgkgs.url = "github:nixos/nixpkgs/nixos-unstable";

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
    nixos-hardware,
    home-manager,
    nixvim,
    nix-matlab,
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
      hardware = nixos-hardware.nixosModules;
      inherit inputs outputs username;
    };

    flake-overlays = [
      nix-matlab.overlay
    ];
  in {
    formatter = nixpkgs.lib.genAttrs ["x86_64-linux"] (system: nixpkgs.legacyPackages.${system}.alejandra);

    devShells = forAllSystems (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};
      in
        import ./shell.nix {inherit pkgs;}
    );

    nixosConfigurations = nixpkgs.lib.genAttrs hosts (
      host: let
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
        }
    );
  };
}
