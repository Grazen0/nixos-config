{pkgs, ...}: (pkgs.writeShellApplication {
  name = "handle-monitor-connect";
  runtimeInputs = with pkgs; [socat hyprland];
  text = builtins.readFile ./handle-monitor-connect.sh;
})
