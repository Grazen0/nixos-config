{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: let
  inherit (lib) mkEnableOption mkPackageOption mkOption types mkIf escapeShellArg;
  cfg = config.programs.matlab;
in {
  options.programs.matlab = {
    enable = mkEnableOption "MATLAB";
    package = mkPackageOption inputs.nix-matlab.packages.${pkgs.system} "matlab" {};
    installDir = mkOption {
      type = types.str;
      description = ''
        Path to assign to `INSTALL_DIR` on {file}`$XDG_CONFIG_HOME/matlab/nix.sh`.
      '';
    };
  };

  config = mkIf cfg.enable {
    home.packages = [cfg.package];

    xdg.configFile."matlab/nix.sh".text =
      # bash
      ''
        INSTALL_DIR=${escapeShellArg cfg.installDir}
      '';
  };
}
