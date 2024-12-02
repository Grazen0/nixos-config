{pkgs, ...}:
pkgs.writeShellApplication {
  name = "handle-monitor-connect";
  runtimeInputs = with pkgs; [socat hyprland];
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
}
