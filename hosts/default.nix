{ lib', ... }:
let
  inherit (lib') mkSystem mkUserModule;

  nixosModules = [
    ../modules/common
    ../modules/nixos
  ];

  homeManagerModules = [
    ../modules/common
    ../modules/home-manager
  ];
in
{
  nitori = mkSystem {
    system = "x86_64-linux";
    modules = [
      ./nitori
      ../profiles/nixos/graphical
      ../components/nixos/laptop
      ../components/nixos/nvidia
      ../components/nixos/gaming
      (mkUserModule {
        username = "jdgt";
        homeManagerModules = [
          ./nitori/home.nix
          ../profiles/home/graphical-extra
          ../components/home/touhou
        ] ++ homeManagerModules;
      })
    ] ++ nixosModules;
  };

  takane = mkSystem {
    system = "x86_64-linux";
    modules = [
      ./takane
      ../profiles/nixos/graphical
      ../components/nixos/laptop
      ../components/nixos/nvidia
      (mkUserModule {
        username = "jdgt";
        homeManagerModules = [
          ./takane/home.nix
          ../profiles/home/graphical
          ../components/home/touhou
        ] ++ homeManagerModules;
      })
    ] ++ nixosModules;
  };

  iso = mkSystem {
    system = "x86_64-linux";
    modules = [
      ./iso
      ../profiles/nixos/graphical
      (mkUserModule {
        username = "nixos";
        homeManagerModules = [
          ./iso/home.nix
          ../profiles/home/graphical
        ] ++ homeManagerModules;
      })
    ] ++ nixosModules;
  };
}
