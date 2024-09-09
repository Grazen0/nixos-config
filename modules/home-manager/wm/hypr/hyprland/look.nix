{
  wayland.windowManager.hyprland.settings = {
    general = rec {
      gaps_in = 4;
      gaps_out = 2 * gaps_in;
      border_size = 3;

      "col.active_border" = "rgb(a3d4d5)";
      "col.inactive_border" = "rgb(727169)";
      no_focus_fallback = true;

      allow_tearing = true;

      layout = "dwindle";
    };

    decoration = {
      drop_shadow = false;

      blur = {
        enabled = true;
        size = 3;
        passes = 1;
        vibrancy = 0.1696;
      };
    };

    animations = {
      enabled = true;

      animation = [
        "windows, 1, 3, default"
        "windowsOut, 1, 4, default, popin 80%"
        "border, 1, 6, default"
        "borderangle, 1, 8, default"
        "fade, 1, 7, default"
        "workspaces, 1, 4, default"
      ];
    };

    dwindle = {
      pseudotile = true;
      preserve_split = true;

      force_split = 2;
      default_split_ratio = 1.04;
    };

    xwayland.force_zero_scaling = true;
  };
}
