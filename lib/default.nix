{
  lib,
  inputs,
  ...
}: let
  inherit (inputs) home-manager nixpkgs-stable self;

  lib' = {
    strings = rec {
      isUpper = s: (lib.toUpper s) == s;
      isLower = s: (lib.toLower s) == s;

      mutFirstChar = f: s: let
        firstChar = f (lib.substring 0 1 s);
        rest = lib.substring 1 (-1) s;
      in
        firstChar + rest;

      kebabToCamel = s:
        mutFirstChar lib.toLower (
          lib.concatMapStrings (mutFirstChar lib.toUpper) (
            lib.splitString "-" s
          )
        );

      camelToKebab = lib.stringAsChars (ch:
        if isUpper ch
        then "-${lib.toLower ch}"
        else ch);
    };

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
