{
  pkgs,
  outputs,
  ...
}: {
  imports = [outputs.homeManagerModules];

  home.packages = with pkgs; [
    prismlauncher # Minecraft
    osu-lazer

    polychromatic

    handle-monitor-connect
  ];

  wayland.windowManager.hyprland.settings = {
    monitor = [
      ", preferred, auto, 1.2"
      "HDMI-A-1, preferred, auto-left, 1"
    ];

    exec-once = [
      "${pkgs.handle-monitor-connect}/bin/handle-monitor-connect"
    ];
  };
}
