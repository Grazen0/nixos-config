{
  config,
  lib,
  ...
}: let
  inherit (lib) mkForce;
in {
  wayland.windowManager.hyprland.settings.input.kb_layout = mkForce "latam,us";

  custom.hyprland.ewwAutoStart = ["desktop-time-alt" "desktop-fortune"];

  programs = {
    foot.settings.main.font = mkForce "${config.theme.font.regular}:size=10:weight=semibold";
    kitty.font.size = mkForce 10;

    spicetify.enable = mkForce false;
  };

  home.stateVersion = "24.05";
}
