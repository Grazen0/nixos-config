{lib, ...}: {
  wayland.windowManager.hyprland.settings = {
    input = {
      kb_layout = lib.mkDefault "us,latam";
      kb_options = "grp:alt_shift_toggle,caps:swapescape";

      numlock_by_default = true;
      follow_mouse = 2;
      float_switch_override_focus = 0;

      touchpad.natural_scroll = true;
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
