{
  config,
  outputs,
  ...
}: {
  imports = [outputs.homeManagerModules];

  wayland.windowManager.hyprland.settings.input.kb_layout = "latam,us";

  grazen.hyprland.ewwAutoStart = ["desktop-time-alt" "desktop-fortune"];

  programs = {
    foot.settings.main.font = "${config.theme.font.regular}:size=10:weight=semibold";

    spicetify.enable = false;
  };

  home.stateVersion = "24.05";
}
