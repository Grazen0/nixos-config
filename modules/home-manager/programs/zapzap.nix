{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.programs.zapzap;
  settingsFormat = pkgs.formats.ini { };
  configFile = settingsFormat.generate "config" cfg.settings;
in
{
  options.programs.zapzap = {
    enable = lib.mkEnableOption "zapzap";
    package = lib.mkPackageOption pkgs "zapzap" { };

    settings = lib.mkOption {
      inherit (settingsFormat) type;
      default = { };
      description = ''
        Configuration written to {file}`$XDG_CONFIG_HOME/ZapZap/ZapZap.conf`.
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ cfg.package ];

    xdg.configFile."ZapZap/ZapZap.conf" = lib.mkIf (cfg.settings != { }) { source = configFile; };
  };
}
