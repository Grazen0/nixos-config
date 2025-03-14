{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkPackageOption mkOption mkIf types;
  cfg = config.programs.nom;
  configFormat = pkgs.formats.yaml {};
in {
  options.programs.nom = let
    fullFeedType = types.submodule {
      options = {
        url = mkOption {type = types.str;};
        name = mkOption {type = types.str;};
      };
    };

    feedType = with types; either str fullFeedType;
  in {
    enable = mkEnableOption "nom";
    package = mkPackageOption pkgs "nom" {};

    feeds = mkOption {
      type = types.listOf feedType;
      default = [];
    };

    extraConfig = mkOption {
      type = configFormat.type;
      default = {};
    };
  };

  config = let
    inherit (lib) isString;

    mkFeed = originalFeed:
      if isString originalFeed
      then {url = originalFeed;}
      else originalFeed;

    feeds = map mkFeed cfg.feeds;
    finalConfig = lib.recursiveUpdate {inherit feeds;} cfg.extraConfig;
    configFile = configFormat.generate "config" finalConfig;
  in
    mkIf cfg.enable {
      home.packages = [cfg.package];

      xdg.configFile."nom/config.yml" = mkIf (cfg.feeds != [] || cfg.extraConfig != {}) {
        source = configFile;
      };
    };
}
