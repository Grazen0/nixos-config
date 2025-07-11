{
  wayland.windowManager.hyprland.settings = {
    input = {
      kb_layout = "us";
      kb_variant = "altgr-intl";
      kb_options = "caps:swapescape,altwin:swap_lalt_lwin";

      numlock_by_default = true;
      follow_mouse = 2;
      float_switch_override_focus = 0;

      touchpad.natural_scroll = true;

      repeat_rate = 50;
      repeat_delay = 300;
    };

    cursor = {
      no_hardware_cursors = true; # Nvidia thing
      no_warps = true;
    };

    gestures = {
      workspace_swipe = true;
      workspace_swipe_fingers = 3;
      workspace_swipe_forever = true;
      workspace_swipe_min_speed_to_force = 7;
    };
  };
}
