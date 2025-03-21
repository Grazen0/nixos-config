{lib', ...}: let
  inherit (lib') mkSystem mkHomeManagerModule;
in {
  nitori = mkSystem {
    system = "x86_64-linux";
    modules = [
      ../modules/common
      ../modules/nixos
      ../system
      ../common
      (mkHomeManagerModule {
        jdgt.imports = [
          ../modules/common
          ../modules/home-manager
          ../common
          ../home
          ./nitori/home.nix
        ];
      })
      ./nitori
    ];
  };

  takane = mkSystem {
    system = "x86_64-linux";
    modules = [
      ../modules/common
      ../modules/nixos
      ../system
      ../common
      (mkHomeManagerModule {
        jdgt.imports = [
          ../modules/common
          ../modules/home-manager
          ../common
          ../home
          ./takane/home.nix
        ];
      })
      ./takane
    ];
  };

  iso = mkSystem {
    system = "x86_64-linux";
    modules = [
      ({modulesPath, ...}: {
        imports = [(modulesPath + "/installer/cd-dvd/installation-cd-minimal.nix")];
      })
    ];
  };
}
