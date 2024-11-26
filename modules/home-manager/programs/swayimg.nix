{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.programs.swayimg;
  settingsFormat = pkgs.formats.ini {};
  configFile = settingsFormat.generate "config" cfg.settings;
in {
  options.programs.swayimg = {
    enable = lib.mkEnableOption "swayimg";
    package = lib.mkPackageOption pkgs "swayimg" {};

    settings = lib.mkOption {
      type = settingsFormat.type;
      default = {};
      description = ''
        Configuration written to {file}`$XDG_CONFIG_HOME/swayimg/config`.
        See {manpage}`swayimgrc(5)` for documentation.
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [cfg.package];

    xdg.configFile."swayimg/config" = lib.mkIf (cfg.settings != {}) {source = configFile;};
  };
}
