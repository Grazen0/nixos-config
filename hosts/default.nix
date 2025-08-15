{ lib', ... }:
let
  inherit (lib') mkSystem mkUserModule;
in
{
  nitori = mkSystem {
    system = "x86_64-linux";
    modules = [ ./nitori/configuration.nix ];
  };

  takane = mkSystem {
    system = "x86_64-linux";
    modules = [ ./takane/configuration.nix ];
  };

  shinmy = mkSystem {
    system = "x86_64-linux";
    modules = [ ./shinmy/configuration.nix ];
  };

  iso = mkSystem {
    system = "x86_64-linux";
    modules = [
      ../options/common
      ../options/nixos
      ../configs/nixos
      ./iso/configuration.nix
      ../profiles/nixos/graphical
      (mkUserModule {
        username = "nixos";
        homeManagerModules = [
          ../options/common
          ../options/home-manager
          ./iso/home.nix
          ../profiles/home/graphical
        ];
      })
    ];
  };
}
