{ lib, pkgs, ... }:
let
  inherit (lib) mkForce;
in
{
  imports = [
    ../../options/common
    ../../options/home-manager
    ../../configs/home

    ../../components/common/theme
    ../../components/home/base
    ../../components/home/tty
    ../../components/home/graphical
  ];

  disabledModules = [
    ../../profiles/home/graphical/programs/equibop
    ../../profiles/home/graphical/packages.nix
    ../../profiles/home/ttymax/packages/dev.nix
  ];

  home.packages = with pkgs; [
    python3
    nodejs

    pavucontrol
    file-roller
  ];

  programs = {
    jetbrains.enable = mkForce false;
    obs-studio.enable = mkForce false;
  };

  home.stateVersion = "24.05";
}
