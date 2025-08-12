{ lib, modulesPath, ... }:
let
  inherit (lib) mkForce;
in
{
  imports = [ (modulesPath + "/installer/cd-dvd/installation-cd-base.nix") ];

  networking.wireless.enable = mkForce false;

  boot.loader = {
    systemd-boot.enable = mkForce false;
    timeout = mkForce 10;
  };

  isoImage.squashfsCompression = "gzip -Xcompression-level 1";

  services = {
    printing.enable = mkForce false;
    gvfs.enable = mkForce false;

    displayManager.autoLogin.enable = false;
  };
}
