{
  lib,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./autostart.nix
    ./binds.nix
    ./env.nix
    ./input.nix
    ./look.nix
    ./misc.nix
    ./rules.nix
    ./workspaces.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;

    xwayland.enable = true;
    systemd.enable = true;

    settings = {
      "$terminal" = "${pkgs.foot}/bin/foot";
      "$browser" = "zen";
      "$fileManager" = "thunar";
      "$fileManagerAlt" = "yazi";

      monitor = lib.mkDefault [", preferred, auto, 1"];
    };

    systemd.variables = ["--all"];
  };

  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    WLR_NO_HARDWARE_CURSORS = "1";
  };
}
