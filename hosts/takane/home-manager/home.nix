{outputs, ...}: {
  imports = [outputs.homeManagerModules];

  wayland.windowManager.hyprland.settings.input.kb_layout = "latam,us";

  home.stateVersion = "24.05";
}
