{
  config,
  lib,
  ...
}: {
  options.xdg = let
    inherit (lib) mkOption mkDefault types;
    inherit (config.home) homeDirectory;

    fileType = types.submodule ({
      name,
      config,
      ...
    }: {
      options = {
        enable = mkOption {
          type = types.bool;
          default = true;
        };
        target = mkOption {
          type = types.str;
          apply = p: let
            inherit (lib) hasPrefix removePrefix;
            absPath =
              if hasPrefix "/" p
              then p
              else "${homeDirectory}/${p}";
          in
            removePrefix (homeDirectory + "/") absPath;
        };

        source = mkOption {
          type = types.path;
        };
      };

      config = {
        target = mkDefault name;
      };
    });
  in {
    configNixFile = mkOption {
      type = types.attrsOf fileType;
      default = {};
    };
  };

  config = let
    inherit (lib) mapAttrs' nameValuePair;
    cfg = config.xdg;
  in {
    home.nixFile = mapAttrs' (n: v: nameValuePair "${cfg.configHome}/${n}" v) cfg.configNixFile;
  };
}
