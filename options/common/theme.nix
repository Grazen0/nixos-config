{ config, lib, ... }:
{
  options.theme =
    let
      inherit (lib) mkOption types;
      inherit (config) theme;
    in
    {
      font = {
        regular = mkOption { type = types.str; };
        mono = mkOption {
          type = types.str;
          default = "${theme.font.regular} Mono";
        };
        propo = mkOption {
          type = types.str;
          default = "${theme.font.regular} Propo";
        };
      };
    };
}
