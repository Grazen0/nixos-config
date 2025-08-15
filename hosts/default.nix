{ lib', ... }:
let
  inherit (lib') mkSystem;
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
    modules = [ ./iso/configuration.nix ];
  };
}
