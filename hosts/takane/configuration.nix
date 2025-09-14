{ lib, lib', ... }:
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
    ../../components/nixos/laptop
    ../../components/nixos/nvidia
    ../../components/nixos/obs-virtual-camera

    (lib'.mkUserModule {
      username = "jdgt";
      homeManagerModules = [ ./home.nix ];
    })

    ./hardware-configuration.nix
  ];

  console.keyMap = mkForce "la-latin1";

  services.xserver.videoDrivers = [ "intel" ]; # Fixes graphical boot issues
  services.tailscale.enable = true;

  virtualisation.docker.rootless.enable = true;

  services.udev.extraRules = ''
    # ST-Link v2 and v2-1 programmer
    ATTRS{idVendor}=="0483", ATTRS{idProduct}=="3748", MODE="0666", GROUP="plugdev"
    ATTRS{idVendor}=="0483", ATTRS{idProduct}=="374b", MODE="0666", GROUP="plugdev"
  '';

  users.groups.plugdev.members = [ "jdgt" ];

  networking.hostName = "takane";
  system.stateVersion = "24.05";
}
