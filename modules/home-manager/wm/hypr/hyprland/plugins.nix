{
  pkgs,
  inputs,
  ...
}: {
  wayland.windowManager.hyprland = {
    plugins = with inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}; [
      hyprwinwrap
    ];

    settings.plugin = {
      hyprwinwrap = {
        class = "hyprwinwrap-bg";
      };
    };
  };
}
