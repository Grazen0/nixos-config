{pkgs, ...}: {
  home.packages = with pkgs; [
    prismlauncher # Minecraft
    osu-lazer
    polychromatic
  ];

  wayland.windowManager.hyprland.settings = {
    monitor = [
      ", preferred, auto, 1.2"
      "HDMI-A-1, preferred, auto-left, 1"
    ];

    exec-once = [
      "${pkgs.customScripts.handle-monitor-connect}/bin/handle-monitor-connect"
    ];
  };

  home.stateVersion = "24.05";
}
