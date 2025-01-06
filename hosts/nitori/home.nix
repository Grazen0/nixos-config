{
  pkgs,
  customPkgs,
  ...
}: {
  home.packages = with pkgs; [
    prismlauncher # Minecraft
    polychromatic

    pgadmin
  ];

  wayland.windowManager.hyprland.settings = {
    monitor = [
      ", preferred, auto, 1.2"
      "HDMI-A-1, preferred, auto-left, 1"
    ];

    exec-once = [
      "${customPkgs.handle-monitor-connect}/bin/handle-monitor-connect"
    ];
  };

  home.stateVersion = "24.05";
}
