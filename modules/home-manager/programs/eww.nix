{
  config,
  lib,
  ...
}: let
  inherit (lib) mkOption types mkIf length;
  cfg = config.programs.eww;
in {
  options.programs.eww = {
    autostart = {
      enable = mkOption {
        type = types.bool;
        default = true;
        description = ''
          Whether to enable auto-starting Eww widgets on window manager start.
        '';
      };

      widgets = mkOption {
        type = with types; listOf str;
        description = ''
          Eww widgets to autostart on login.
        '';
      };
    };
  };

  config = mkIf (cfg.enable && cfg.autostart.enable && length cfg.autostart.widgets != 0) (let
    inherit (lib) escapeShellArg;
    inherit (lib.strings) concatStringsSep;

    uwsmApp = "uwsm app --";
    eww = "${config.programs.eww.package}/bin/eww";
    autostartCommand = "${uwsmApp} ${eww} open-many ${concatStringsSep " " cfg.autostart.widgets}";
  in {
    wayland.windowManager = {
      hyprland.settings.exec-once = [
        (mkIf config.wayland.windowManager.hyprland.enable autostartCommand)
      ];

      river.settings.spawn = [
        (mkIf config.wayland.windowManager.river.enable (escapeShellArg autostartCommand))
      ];
    };
  });
}
