{config, ...}: {
  wayland.windowManager.hyprland.settings = {
    monitor = [
      ", preferred, auto, 1.2"
      "HDMI-A-1, preferred, auto-left, 1"
    ];

    exec-once = [
      "handle-monitor-connect"
    ];

    input.kb_layout = "us,latam";
  };
}
