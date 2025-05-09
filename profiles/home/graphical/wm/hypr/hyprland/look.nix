{ config, ... }:
{
  wayland.windowManager.hyprland.settings =
    let
      inherit (config) theme;
      colors = theme.colors.hex;
    in
    {
      general = {
        gaps_in = 4;
        gaps_out = 8;
        border_size = 3;

        "col.active_border" = "rgb(${colors.blue}) rgb(${colors.magenta}) 45deg";
        "col.inactive_border" = "rgba(${colors.brightBlack}ee)";
        no_focus_fallback = true;

        layout = "dwindle";

        allow_tearing = true;
      };

      dwindle = {
        force_split = 2; # Split to the bottom right
        preserve_split = true;
        default_split_ratio = 1.04;
      };

      decoration = {
        rounding = 6;

        shadow = {
          enabled = true;
          color = "0xcc${colors.black}";
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
        first_launch_animation = false;

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
