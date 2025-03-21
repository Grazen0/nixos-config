{
  lib,
  modulesPath,
  ...
}: let
  inherit (lib) mkForce;
in {
  imports = [(modulesPath + "/installer/cd-dvd/installation-cd-minimal.nix")];

  networking.wireless = mkForce false;

  boot.loader.systemd-boot.enable = mkForce false;
}
