{outputs, ...}: {
  imports = [outputs.homeManagerModules];

  wayland.windowManager.hyprland.settings.input.kb_layout = "latam,us";

  myOwnConfig.hyprland.ewwAutoStart = ["desktop-time-alt" "desktop-fortune"];

  home.stateVersion = "24.05";
}
