{ config, lib, ... }:
let
  cfg = config.programs.river;
in
{
  options = {
    programs.river.withUWSM = lib.mkEnableOption null // {
      description = ''
        Launch River with the UWSM (Universal Wayland Session Manager) session manager.
      '';
    };
  };

  config = lib.mkIf (cfg.enable && cfg.withUWSM) {
    programs.uwsm = {
      enable = true;
      waylandCompositors.river = {
        prettyName = "River";
        comment = "River compositor managed by UWSM";
        binPath = "/run/current-system/sw/bin/river";
      };
    };
  };
}
