{ lib, pkgs, ... }:
let
  inherit (lib) mkForce;
in
{
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
