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

  config =
    {
      home.file.wallpaper = lib.mkIf cfg.wallpaper.enable {
        inherit (cfg.wallpaper) source target;
      };
    }
    // lib.mkIf cfg.cursor.enable {
      home.pointerCursor = {
        gtk.enable = true;
        inherit (cfg.cursor) package name size;
      };

      gtk.cursorTheme = {
        inherit (cfg.cursor) package name size;
      };
    };
}
