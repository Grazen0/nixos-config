{
  config,
  lib,
  pkgs,
  inputs,
  ...
}@moduleArgs:
{
  options =
    let
      inherit (lib) mkOption;
      inherit (config.home) homeDirectory;

      libFileType = import "${inputs.home-manager}/modules/lib/file-type.nix" {
        inherit homeDirectory lib pkgs;
      };
    in
    {
      home = {
        nixFile = mkOption {
          default = { };
          type = libFileType.fileType "home.nixFile" "{env}`HOME`" homeDirectory;
        };
      };
    };

  config =
    let
      inherit (lib)
        filterAttrs
        mapAttrsToList
        mergeAttrsList
        pathIsDirectory
        path
        removeSuffix
        hasSuffix
        mapAttrs'
        nameValuePair
        ;
      cfg = config.home;

      filteredNixFiles = filterAttrs (_n: f: f.enable) cfg.nixFile;

      mkEntries =
        basePath: target:
        assert pathIsDirectory basePath;
        (
          let
            dirItems = builtins.readDir basePath;

            subEntries = mapAttrsToList (
              name: type:
              let
                fullPath = path.append basePath name;
              in
              if type == "directory" then
                let
                  subEntries = mkEntries fullPath name;
                in
                mapAttrs' (n: v: nameValuePair "${target}/${n}" v) subEntries
              else if (hasSuffix ".nix" name) then
                let
                  unprefixedName = removeSuffix ".nix" name;
                in
                {
                  "${target}/${unprefixedName}" = {
                    text = (import fullPath) moduleArgs;
                  };
                }
              else
                {
                  "${target}/${name}" = {
                    source = fullPath;
                  };
                }
            ) dirItems;
          in
          mergeAttrsList subEntries
        );

      entries = mapAttrsToList (
        name: value:
        if !(pathIsDirectory value.source) then
          {
            ${name} = {
              inherit (value) target;
              text = (import value.source) moduleArgs;
            };
          }
        else
          mkEntries value.source value.target
      ) filteredNixFiles;
    in
    {
      home.file = mergeAttrsList entries;
    };
}
