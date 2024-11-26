{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.programs.peaclock;
in {
  options.programs.peaclock = {
    enable = lib.mkEnableOption "peaclock";
    package = lib.mkPackageOption pkgs "peaclock" {};

    extraConfig = lib.mkOption {
      type = lib.types.lines;
      default = "";
      description = ''
        Configuration written to {file}`$XDG_CONFIG_HOME/peaclock/config`.
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [peaclock];

    xdg.configFile."peaclock/config" = lib.mkIf (cfg.extraConfig != "") {
      text = cfg.extraConfig;
    };
  };
}
