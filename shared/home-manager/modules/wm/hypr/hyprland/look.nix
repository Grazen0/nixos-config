{
  wayland.windowManager.hyprland.settings = {
    general = {
      gaps_in = 6;
      gaps_out = 12;
      border_size = 3;

      "col.active_border" = "rgb(a3d4d5) rgb(938aa9) 45deg";
      "col.inactive_border" = "rgba(727169aa)";
      no_focus_fallback = true;

      allow_tearing = true;

      layout = "dwindle";
    };

    decoration = {
      rounding = 8;

      drop_shadow = true;
      shadow_range = 6;
      shadow_render_power = 3;
      "col.shadow" = "rgba(16161d80)";

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

    xwayland = {
      force_zero_scaling = true;
    };
  };
}
