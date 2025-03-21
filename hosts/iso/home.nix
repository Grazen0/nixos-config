{
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkForce;
in {
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
    librewolf-bin
  ];

  programs = {
    jetbrains.enable = mkForce false;
  };

  meta.mainPrograms = {
    browser = mkForce "librewolf";
  };

  home.stateVersion = "24.05";
}
