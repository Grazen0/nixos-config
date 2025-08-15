{
  lib,
  lib',
  modulesPath,
  ...
}:
let
  inherit (lib) mkForce;
in
{
  imports = [
    ../../options/common
    ../../options/nixos
    ../../configs/nixos

    ../../components/common/theme
    ../../components/nixos/base
    ../../components/nixos/graphical

    (lib'.mkUserModule {
      username = "nixos";
      homeManagerModules = [ ./home.nix ];
    })

    (modulesPath + "/installer/cd-dvd/installation-cd-base.nix")
  ];

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
