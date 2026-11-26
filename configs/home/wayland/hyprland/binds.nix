{
  config,
  lib,
  pkgs,
  customPkgs,
  ...
}:
{
  home.packages = lib.optionals config.wayland.windowManager.hyprland.enable [ pkgs.wtype ];

  wayland.windowManager.hyprland.extraLuaFiles.commands = {
    autoLoad = false;
    content = "return ${
      lib.generators.toLua { } {
        inherit (config.meta.mainPrograms)
          terminal
          browser
          fileManager
          fileManagerCli
          appLauncher
          dmenu
          ;
        grim = "${pkgs.grim}/bin/grim";
        slurp = "${pkgs.slurp}/bin/slurp";
        playerctl = "${pkgs.playerctl}/bin/playerctl -p mopidy";
        pamixer = "${pkgs.pamixer}/bin/pamixer";
        wlCopy = "${pkgs.wl-clipboard}/bin/wl-copy";
        cliphist = "${config.services.cliphist.package}/bin/cliphist";
        bemoji = "${pkgs.bemoji}/bin/bemoji";
        brightnessctl = "${pkgs.brightnessctl}/bin/brightnessctl";
        volumeUpdate = "${customPkgs.volume-update}/bin/volume-update";
        powerMenu = "${customPkgs.fuzzel-power-menu}/bin/fuzzel-power-menu";
      }
    }";
  };
}
