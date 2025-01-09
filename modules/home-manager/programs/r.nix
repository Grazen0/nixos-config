{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.programs.r;
  prefsFormat = pkgs.formats.json {};
  prefsFile = prefsFormat.generate "rstudio-prefs.json" cfg.rstudio.preferences;
in {
  options.programs.r = {
    enable = lib.mkEnableOption "r";
    package = lib.mkPackageOption pkgs "rWrapper" {};

    rPackages = lib.mkOption {
      type = with lib.types; listOf package;
      default = [];
      description = ''
        Packages to be included in the R installation.
      '';
    };

    profile = lib.mkOption {
      type = lib.types.lines;
      description = ''
        Contents written to {file}`$HOME/.Rprofile`.
      '';
    };

    rstudio = {
      enable = lib.mkEnableOption "rstudio";
      package = lib.mkPackageOption pkgs "rstudioWrapper" {};

      themes = lib.mkOption {
        type = with lib.types; attrsOf lines;
        description = ''
          Contents of the theme files to be placed inside {file}`$XDG_CONFIG_HOME/rstudio/themes`.
        '';
      };

      includeRPackages = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = ''
          Include R packages in RStudio packages.
        '';
      };

      rPackages = lib.mkOption {
        type = with lib.types; listOf package;
        default = [];
        description = ''
          Packages to be included in the RStudio installation
        '';
      };

      preferences = lib.mkOption {
        type = prefsFormat.type;
        default = {};
        description = ''
          Preferences to be written to {file}`$XDG_CONFIG_HOME/rstudio/rstudio-prefs.json`.
        '';
      };
    };
  };

  config = let
    inherit (cfg) rstudio;
  in
    lib.mkIf cfg.enable {
      home.packages = let
        rWrapped = cfg.package.override {
          packages = cfg.rPackages;
        };

        rstudioWrapped = cfg.rstudio.package.override {
          packages =
            cfg.rstudio.rPackages
            ++ (
              if cfg.rstudio.includeRPackages
              then cfg.rPackages
              else []
            );
        };
      in [
        rWrapped
        (lib.mkIf rstudio.enable rstudioWrapped)
      ];

      home.file.rProfile = lib.mkIf (cfg.enable && cfg.profile != "") {
        target = "${config.home.homeDirectory}/.Rprofile";
        text = cfg.profile;
      };

      xdg.configFile =
        {
          "rstudio/rstudio-prefs.json" = lib.mkIf (rstudio.enable && rstudio.preferences != {}) {
            source = prefsFile;
          };
        }
        // lib.listToAttrs (lib.mapAttrsToList (theme: text: {
            name = "rstudio/themes/${theme}.rstheme";
            value = {inherit text;};
          })
          rstudio.themes);
    };
}
