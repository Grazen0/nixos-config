{theme, ...}: {
  wayland.windowManager.hyprland.settings = {
    general = let
      colors = theme.colors.hexNh;
    in {
      gaps_in = 4;
      gaps_out = 8;
      border_size = 3;

      "col.active_border" = "rgb(${colors.blue}) rgb(${colors.magenta}) 45deg";
      "col.inactive_border" = "rgba(${colors.brightBlack}ee)";
      no_focus_fallback = true;

      layout = "master";

      allow_tearing = true;
    };

    decoration = {
      rounding = 6;

      shadow = {
        enabled = true;
        color = "0xcc${theme.colors.hexNh.black}";
        range = 32;
      };

      blur = {
        enabled = true;
        size = 10;
        passes = 3;
      };
    };

    animations = {
      enabled = true;
      bezier = "expo, 0.16, 1, 0.3, 1";
      animation = [
        "windows, 1, 3, expo"
        "windowsOut, 1, 3, expo, popin 80%"
        "border, 1, 4, expo"
        "borderangle, 1, 3, expo"
        "fade, 1, 3, expo"
        "workspaces, 1, 3, expo"
        "layersIn, 1, 4, expo"
      ];
    };

    xwayland.force_zero_scaling = true;
  };
}
