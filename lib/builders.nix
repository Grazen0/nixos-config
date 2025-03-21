{
  lib,
  lib',
  inputs,
  ...
}: let
  inherit (inputs) home-manager nixpkgs-stable self;

  specialArgsFor = system: {
    inherit lib' inputs;
    stablePkgs = import nixpkgs-stable {
      inherit system;
      config.allowUnfree = true;
    };
    customPkgs = self.packages.${system};
  };
in {
  mkSystem = {
    system,
    modules,
  }:
    lib.nixosSystem rec {
      inherit system modules;
      specialArgs = specialArgsFor system;
    };

  mkHomeManagerModule = users: {pkgs, ...}: {
    imports = [home-manager.nixosModules.home-manager];

    home-manager = {
      verbose = true;
      useGlobalPkgs = true;
      useUserPackages = true;
      extraSpecialArgs = specialArgsFor pkgs.system;
      backupFileExtension = "backup";
      users =
        lib.mapAttrs
        (user: value: {meta.mainUser = user;} // value)
        users;
    };
  };
}
