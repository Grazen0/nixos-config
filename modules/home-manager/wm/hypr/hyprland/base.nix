{
  lib,
  pkgs,
  ...
}: {
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    systemd.enable = true;

    settings = {
      "$terminal" = "${pkgs.foot}/bin/foot";
      "$browser" = "zen";
      "$fileManager" = "thunar";

      monitor = lib.mkDefault [", preferred, auto, 1"];
    };

    systemd.variables = ["--all"];
  };

  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    WLR_NO_HARDWARE_CURSORS = "1";
  };
}
