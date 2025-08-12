{ lib, lib', ... }:
let
  inherit (lib) mkForce;
in
{
  imports = [
    ../../options/common
    ../../options/nixos
    ../../configs/nixos

    ../components/common/theme
    ../components/nixos/base
    ../components/nixos/graphical
    ../components/nixos/laptop
    ../components/nixos/nvidia

    ./hardware-configuration.nix

    (lib'.mkUserModule {
      username = "jdgt";
      homeManagerModules = [
        ../../options/common
        ../../options/home-manager
        ../../configs/home

        ../../components/common/theme
        ../../components/home/base
        ../../components/home/graphical
        ../../components/home/touhou
        ../../components/home/tty

        ./home.nix
      ];
    })
  ];

  console.keyMap = mkForce "la-latin1";

  services.xserver.videoDrivers = [ "intel" ]; # Fixes graphical boot issues
  services.tailscale.enable = true;

  virtualisation.docker.enable = true;

  networking.hostName = "takane";
  system.stateVersion = "24.05";
}
