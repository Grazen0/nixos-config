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

  mkUserModule = {
    username,
    extraGroups ? ["wheel" "audio" "networkmanager"],
    homeManagerModules ? null,
    ...
  }: {pkgs, ...}: let
    withHomeManager = homeManagerModules != null;
  in {
    imports = lib.optionals withHomeManager [home-manager.nixosModules.home-manager];

    users.users.${username} = {
      isNormalUser = true;
      inherit extraGroups;
    };

    home-manager = lib.mkIf withHomeManager {
      verbose = true;
      useGlobalPkgs = true;
      useUserPackages = true;
      extraSpecialArgs = specialArgsFor pkgs.system;
      backupFileExtension = "backup";

      users.${username} = {
        imports = homeManagerModules;
        meta.mainUser = username;
      };
    };
  };
}
