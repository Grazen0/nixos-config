{config, ...}: {
  wayland.windowManager.hyprland.settings = {
    general = with config.theme.colors.hexNh; {
      gaps_in = 4;
      gaps_out = 0;
      border_size = 3;

      "col.active_border" = "rgb(${blue})";
      "col.inactive_border" = "rgb(${brightBlack})";
      no_focus_fallback = true;

      allow_tearing = true;

      layout = "master";
    };

    decoration = {
      shadow .enabled = false;
      blur.enabled = false;
    };

    animations = {
      enabled = true;

      animation = [
        "windows, 1, 3, default"
        "windowsOut, 1, 4, default, popin 80%"
        "border, 1, 4, default"
        "borderangle, 1, 8, default"
        "fade, 1, 7, default"
        "workspaces, 1, 4, default"
      ];
    };

    xwayland.force_zero_scaling = true;
  };
}
