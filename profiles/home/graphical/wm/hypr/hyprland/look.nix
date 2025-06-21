{ config, ... }:
{
  wayland.windowManager.hyprland.settings =
    let
      inherit (config) scheme;
    in
    {
      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;

        "col.active_border" = "rgb(${scheme.blue})";
        "col.inactive_border" = "rgb(${scheme.base04})";

        no_focus_fallback = true;
        allow_tearing = true;
      };

      dwindle = {
        force_split = 2; # Split to the bottom right
        preserve_split = true;
        default_split_ratio = 1.04;
      };

      decoration = {
        rounding = 0;
        shadow.enabled = false;
        blur.enabled = false;
      };

      animations = {
        enabled = false;
        first_launch_animation = false;
      };

      xwayland.force_zero_scaling = true;
    };
}
