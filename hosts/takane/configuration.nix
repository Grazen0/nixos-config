{ lib, ... }:
let
  inherit (lib) mkForce;
in
{
  imports = [ ./hardware-configuration.nix ];

  console.keyMap = mkForce "la-latin1";

  services.xserver.videoDrivers = [ "intel" ];

  networking.hostName = "takane";
  system.stateVersion = "24.05";
}
