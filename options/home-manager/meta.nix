{ lib, ... }:
let
  inherit (lib) mkOption types;
in
{
  options.meta = {
    mainPrograms = {
      terminal = mkOption { type = types.str; };
      editor = mkOption {
        type = with types; nullOr str;
        default = "nano";
      };
      browser = mkOption { type = types.str; };
      fileManager = mkOption { type = types.str; };
      fileManagerCli = mkOption { type = types.str; };
      appLauncher = mkOption { type = types.str; };
      dmenu = mkOption { type = types.str; };
    };

    eww = {
      autostartWidgets = mkOption {
        type = with types; listOf str;
        default = [
          "desktop-clock"
          "desktop-cow"
        ];
      };

      battery = mkOption {
        type = types.str;
        default = "BAT0";
      };

      outputs = {
        primary = mkOption {
          type = types.str;
          default = "";
        };
        secondary = mkOption {
          type = types.str;
          default = "";
        };
      };
    };
  };
}
