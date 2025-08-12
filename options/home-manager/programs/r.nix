{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib)
    mkEnableOption
    mkPackageOption
    mkOption
    types
    ;
  cfg = config.programs.r;
  prefsFormat = pkgs.formats.json { };
  prefsFile = prefsFormat.generate "rstudio-prefs.json" cfg.rstudio.preferences;
in
{
  options.programs.r = {
    enable = mkEnableOption "r";
    package = mkPackageOption pkgs "rWrapper" { };

    rPackages = mkOption {
      type = with types; listOf package;
      default = [ ];
      description = ''
        Packages to be included in the R installation.
      '';
    };

    finalPackage = mkOption { type = types.package; };

    profile = mkOption {
      type = types.lines;
      description = ''
        Contents written to {file}`$HOME/.Rprofile`.
      '';
    };

    rstudio = {
      enable = mkEnableOption "rstudio";
      package = mkPackageOption pkgs "rstudioWrapper" { };

      finalPackage = mkOption { type = types.package; };

      themes = mkOption {
        type = with types; attrsOf lines;
        description = ''
          Contents of the theme files to be placed inside {file}`$XDG_CONFIG_HOME/rstudio/themes`.
        '';
      };

      includeRPackages = mkOption {
        type = types.bool;
        default = true;
        description = ''
          Include R packages in RStudio packages.
        '';
      };

      rPackages = mkOption {
        type = with types; listOf package;
        default = [ ];
        description = ''
          Packages to be included in the RStudio installation
        '';
      };

      preferences = mkOption {
        inherit (prefsFormat) type;
        default = { };
        description = ''
          Preferences to be written to {file}`$XDG_CONFIG_HOME/rstudio/rstudio-prefs.json`.
        '';
      };
    };
  };

  config =
    let
      inherit (lib)
        mkIf
        optionals
        listToAttrs
        mapAttrsToList
        ;
    in
    mkIf cfg.enable {
      programs.r = {
        finalPackage = cfg.package.override { packages = cfg.rPackages; };

        rstudio.finalPackage = mkIf cfg.rstudio.enable (
          cfg.rstudio.package.override {
            packages = cfg.rstudio.rPackages ++ (if cfg.rstudio.includeRPackages then cfg.rPackages else [ ]);
          }
        );
      };

      home.packages = [ cfg.finalPackage ] ++ optionals cfg.rstudio.enable [ cfg.rstudio.finalPackage ];

      home.file.rProfile = mkIf (cfg.enable && cfg.profile != "") {
        target = "${config.home.homeDirectory}/.Rprofile";
        text = cfg.profile;
      };

      xdg.configFile =
        {
          "rstudio/rstudio-prefs.json" = mkIf (cfg.rstudio.enable && cfg.rstudio.preferences != { }) {
            source = prefsFile;
          };
        }
        // listToAttrs (
          mapAttrsToList (theme: text: {
            name = "rstudio/themes/${theme}.rstheme";
            value = { inherit text; };
          }) cfg.rstudio.themes
        );
    };
}
