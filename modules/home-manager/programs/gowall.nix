{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkPackageOption mkOption mkIf;
  cfg = config.programs.gowall;
  configFormat = pkgs.formats.yaml {};
  configFile = configFormat.generate "config" cfg.extraConfig;
in {
  options.programs.gowall = {
    enable = mkEnableOption "gowall";
    package = mkPackageOption pkgs "gowall" {};

    extraConfig = mkOption {
      type = configFormat.type;
      default = {};
    };
  };

  config = mkIf cfg.enable {
    home.packages = [cfg.package];

    xdg.configFile."gowall/config.yml" = mkIf (cfg.extraConfig != {}) {
      source = configFile;
    };
  };
}
