{
  config,
  lib,
  ...
}: let
  cfg = config.programs.ncmpcpp;
in {
  options.programs.ncmpcpp = let
    inherit (lib) mkOption types;
    settingsType = with types; attrsOf (oneOf [bool int str]);
  in {
    extraSettings = mkOption {
      type = with types; attrsOf settingsType;
      description = ''
        Extra settings files to be written as .conf files to {FILE}`$XDG_CONFIG_HOME/ncmpcpp`.
      '';
    };
  };

  config = let
    inherit (lib) mkIf mapAttrs' concatStringsSep mapAttrsToList;

    # Stuff stolen from https://github.com/nix-community/home-manager/blob/master/modules/programs/ncmpcpp.nix#L9-L19
    renderValue = option:
      {
        int = toString option;
        bool = lib.hm.booleans.yesNo option;
        string = option;
      }
      .${builtins.typeOf option};

    renderSettings = settings: concatStringsSep "\n" (mapAttrsToList renderSetting settings);

    renderSetting = name: value: "${name}=${renderValue value}";
  in
    mkIf cfg.enable {
      xdg.configFile =
        mapAttrs' (name: value: {
          name = "ncmpcpp/${name}.conf";
          value = {
            text = renderSettings value + "\n";
          };
        })
        cfg.extraSettings;
    };
}
