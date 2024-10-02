{outputs, ...}: {
  imports = [outputs.homeManagerModules];

  wayland.windowManager.hyprland.settings.input.kb_layout = "latam,us";

  myOwnConfig.hyprland.ewwAutoStart = ["desktop-time-alt" "desktop-fortune"];

  programs.foot.settings.main.font = "JetBrainsMonoNL Nerd Font:size=10:weight=semibold";

  home.stateVersion = "24.05";
}
