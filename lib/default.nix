{
  lib,
  inputs,
  ...
}: let
  inherit (inputs) home-manager nixpkgs-stable self;

  lib' = rec {
    math = rec {
      pow = base: exp:
        if exp == 0
        then 1
        else if exp < 0
        then 1 / pow base (-exp)
        else base * (pow base (exp - 1));
    };

    numeric = {
      base16To10 = exponent: scalar: scalar * math.pow 16 exponent;
    };

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

      # Credit: https://github.com/Misterio77/nix-colors/blob/b92df8f5eb1fa20d8e09810c03c9dc0d94ef2820/lib/core/conversions.nix#L87
      hexCharToDec = hex: let
        lowerHex = lib.toLower hex;
        hexToDecMap = {
          "0" = 0;
          "1" = 1;
          "2" = 2;
          "3" = 3;
          "4" = 4;
          "5" = 5;
          "6" = 6;
          "7" = 7;
          "8" = 8;
          "9" = 9;
          "a" = 10;
          "b" = 11;
          "c" = 12;
          "d" = 13;
          "e" = 14;
          "f" = 15;
        };
      in
        if builtins.stringLength hex != 1
        then throw "Function only accepts a single character."
        else if hexToDecMap ? ${lowerHex}
        then hexToDecMap."${lowerHex}"
        else throw "Character ${hex} is not a hexadecimal value.";

      # Credit: https://github.com/Misterio77/nix-colors/blob/b92df8f5eb1fa20d8e09810c03c9dc0d94ef2820/lib/core/conversions.nix#L87
      hexToDec = hex: let
        inherit (lib) stringToCharacters reverseList imap0 foldl;
        decimals = map hexCharToDec (stringToCharacters hex);
        decimalsAscending = reverseList decimals;
        decimalsPowered = imap0 numeric.base16To10 decimalsAscending;
      in
        foldl builtins.add 0 decimalsPowered;

      # Credit: https://github.com/Misterio77/nix-colors/blob/b92df8f5eb1fa20d8e09810c03c9dc0d94ef2820/lib/core/conversions.nix#L87
      hexToRGB = hex: let
        rgbStartIndex = [0 2 4];
        hexList = map (x: builtins.substring x 2 hex) rgbStartIndex;
        hexLength = builtins.stringLength hex;
      in
        if hexLength != 6
        then
          throw ''
            Unsupported hex string length of ${toString hexLength}.
            Length must be exactly 6.
          ''
        else map hexToDec hexList;
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
