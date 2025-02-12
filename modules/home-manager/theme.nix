{
  config,
  lib,
  ...
}: let
  inherit (lib) mkOption mkEnableOption types;
  cfg = config.theme.home;
in {
  options.theme.home = {
    wallpaper = {
      enable = mkEnableOption "wallpaper theming";

      source = mkOption {
        type = types.path;
        description = ''
          Path to the image to use as desktop wallpaper.
        '';
      };

      target = mkOption {
        type = with types; nullOr str;
        description = ''
          Target path to place the wallpaper in.
        '';
        default = "${config.xdg.userDirs.pictures}/${baseNameOf cfg.wallpaper.source}";
      };
    };

    cursor = {
      enable = mkEnableOption "cursor theming";

      package = mkOption {
        type = types.package;
        description = ''
          Cursor package to use.
        '';
      };

      name = mkOption {
        type = types.str;
        description = ''
          Name of the cursor theme.
        '';
      };

      size = mkOption {
        type = types.int;
        default = 32;
      };
    };
  };

  config = let
    inherit (lib) mkIf optionals;
    inherit (cfg) wallpaper cursor;
  in {
    home.file.wallpaper = mkIf wallpaper.enable {
      inherit (wallpaper) source target;
    };

    home.pointerCursor = mkIf cursor.enable {
      inherit (cursor) package name size;
      gtk.enable = true;
    };

    gtk.cursorTheme = mkIf cursor.enable {
      inherit (cursor) package name size;
    };

    home.sessionVariables = {
      XCURSOR_THEME = mkIf cursor.enable (cursor.name);
      XCURSOR_SIZE = mkIf cursor.enable (toString cursor.size);
    };

    wayland.windowManager.hyprland.settings.env =
      optionals
      config.wayland.windowManager.hyprland.enable
      [
        "XCURSOR_THEME,${cursor.name}"
        "XCURSOR_SIZE,${toString cursor.size}"
      ];
  };
}
