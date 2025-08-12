{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
let
  cfg = config.xdg;
in
{
  options.xdg =
    let
      inherit (lib) mkOption;
      inherit (config.home) homeDirectory;

      libFileType = import "${inputs.home-manager}/modules/lib/file-type.nix" {
        inherit homeDirectory lib pkgs;
      };
    in
    {
      nixConfigFile = mkOption {
        type = libFileType.fileType "xdg.nixConfigFile" "{var}`xdg.configHome`" cfg.configHome;
        default = { };
      };
    };

  config =
    let
      inherit (lib) mapAttrs' nameValuePair;
    in
    {
      home.nixFile = mapAttrs' (n: v: nameValuePair "${cfg.configHome}/${n}" v) cfg.nixConfigFile;
    };
}
