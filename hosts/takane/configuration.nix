{ lib, ... }:
let
  inherit (lib) mkForce;
in
{
  imports = [ ./hardware-configuration.nix ];

  console.keyMap = mkForce "la-latin1";

  programs.steam.enable = mkForce false;

  networking.hostName = "takane";
  system.stateVersion = "24.05";
}
