{
  lib,
  inputs,
  ...
}: let
  inherit (inputs) home-manager nixpkgs-stable self;

  lib' = let
    math = import ./math.nix {inherit lib lib';};
    strings = import ./strings.nix {inherit lib lib';};
    river = import ./river.nix {inherit lib lib';};
  in
    math
    // strings
    // {
      inherit math strings river;

      mkSystem = {
        hostName,
        system,
        extraModules ? [],
      }:
        lib.nixosSystem rec {
          inherit system;

          modules =
            [
              home-manager.nixosModules.home-manager
              ../modules/common
              ../modules/nixos
              ../system
              ../hosts/${hostName}
              {
                networking = {inherit hostName;};

                home-manager = {
                  verbose = true;
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  extraSpecialArgs = specialArgs;
                  backupFileExtension = "backup";

                  users.jdgt.imports = [
                    ../modules/common
                    ../modules/home-manager
                    ../home
                  ];
                };
              }
            ]
            ++ extraModules;

          specialArgs = {
            inherit lib' inputs;
            stablePkgs = import nixpkgs-stable {
              inherit system;
              config.allowUnfree = true;
            };
            customPkgs = self.packages.${system};
          };
        };
    };
in
  lib'
