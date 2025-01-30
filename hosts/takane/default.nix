{lib, ...}: let
  inherit (lib) mkForce;
in {
  imports = [
    ./hardware-configuration.nix
  ];

  console.keyMap = mkForce "la-latin1";

  programs.steam.enable = mkForce false;

  home-manager.users.jdgt.imports = [./home.nix];

  system.stateVersion = "24.05";
}
