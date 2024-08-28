{
  pkgs,
  outputs,
  ...
}: {
  imports = [outputs.homeManagerModules];

  home.packages = let
    handle-monitor-connect = pkgs.writeShellApplication {
      name = "handle-monitor-connect";
      runtimeInputs = with pkgs; [
        socat
        hyprland
      ];
      text = ''
        handle() {
          case $1 in monitoradded*)
            hyprctl dispatch moveworkspacetomonitor "6 HDMI-A-1"
            hyprctl dispatch moveworkspacetomonitor "7 HDMI-A-1"
            hyprctl dispatch moveworkspacetomonitor "8 HDMI-A-1"
            hyprctl dispatch moveworkspacetomonitor "9 HDMI-A-1"
            hyprctl dispatch moveworkspacetomonitor "10 HDMI-A-1"
          esac
        }

        socat - "UNIX-CONNECT:''$XDG_RUNTIME_DIR/hypr/''${HYPRLAND_INSTANCE_SIGNATURE}/.socket2.sock" | while read -r line; do handle "$line"; done
      '';
    };
  in [
    handle-monitor-connect
  ];

  wayland.windowManager.hyprland.settings = {
    monitor = [
      ", preferred, auto, 1.2"
      "HDMI-A-1, preferred, auto-left, 1"
    ];

    exec-once = [
      "handle-monitor-connect"
    ];
  };
}
