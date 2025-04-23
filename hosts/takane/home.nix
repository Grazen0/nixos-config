{ config, lib, ... }:
let
  inherit (lib) mkForce;
in
{
  wayland.windowManager = {
    hyprland.settings.input.kb_layout = mkForce "latam,us";
    river.settings.keyboard-layout = mkForce "-options 'grp:alt_shift_toggle,caps:swapescape' 'latam,us'";
  };

  meta.eww.outputs.primary = "BOE";

  programs = {
    foot.settings.main.font = mkForce "${config.theme.font.regular}:size=10.5";
    kitty.font.size = mkForce 10;

    wlogout.layout =
      let
        height = 1;
      in
      [
        {
          label = "lock";
          action = "loginctl lock-session";
          text = "Lock";
          keybind = "l";
          inherit height;
        }
        {
          label = "hibernate";
          action = "systemctl hibernate";
          text = "Hibernate";
          keybind = "h";
          inherit height;
        }
        {
          label = "logout";
          action = "loginctl terminate-user $USER";
          text = "Logout";
          keybind = "e";
          inherit height;
        }
        {
          label = "shutdown";
          action = "systemctl poweroff";
          text = "Shutdown";
          keybind = "s";
          inherit height;
        }
        {
          label = "suspend";
          action = "systemctl suspend";
          text = "Suspend";
          keybind = "u";
          inherit height;
        }
        {
          label = "reboot";
          action = "systemctl reboot";
          text = "Reboot";
          keybind = "r";
          inherit height;
        }
      ];
  };

  home.stateVersion = "24.05";
}
