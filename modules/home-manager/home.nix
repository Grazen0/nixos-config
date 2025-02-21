{
  config,
  lib,
  ...
} @ moduleArgs: {
  options = let
    inherit (lib) mkOption types mkDefault;
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
    home = {
      nixFile = mkOption {
        default = {};
        type = with types; attrsOf fileType;
      };
    };
  };

  config = let
    inherit (lib) filterAttrs mapAttrsToList mergeAttrs foldl' pathIsDirectory path removeSuffix hasSuffix mapAttrs' nameValuePair;
    cfg = config.home;

    filteredNixFiles = filterAttrs (n: f: f.enable) cfg.nixFile;

    mkEntries = basePath: target:
      assert pathIsDirectory basePath; (
        let
          dirItems = builtins.readDir basePath;

          subEntries =
            mapAttrsToList (name: type: let
              fullPath = path.append basePath name;
            in (
              if type == "directory"
              then let
                subEntries = mkEntries fullPath name;
              in
                mapAttrs' (n: v: nameValuePair "${target}/${n}" v) subEntries
              else if (hasSuffix ".nix" name)
              then let
                unprefixedName = removeSuffix ".nix" name;
              in {
                "${target}/${unprefixedName}" = {
                  text = (import fullPath) moduleArgs;
                };
              }
              else {
                "${target}/${name}" = {
                  source = fullPath;
                };
              }
            ))
            dirItems;
        in
          foldl' mergeAttrs {} subEntries
      );

    entries = mapAttrsToList (name: value:
      if !(pathIsDirectory value.source)
      then {
        ${name} = {
          inherit (value) target;
          text = (import value.source) moduleArgs;
        };
      }
      else mkEntries value.source value.target)
    filteredNixFiles;

    files = foldl' mergeAttrs {} entries;
  in {
    home.file = files;
  };
}
