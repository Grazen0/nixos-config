{
  config,
  lib,
  ...
}: {
  options = {
    programs.river.withUWSM =
      lib.mkEnableOption null
      // {
        description = ''
          Launch River with the UWSM (Universal Wayland Session Manager) session manager.
        '';
      };
  };

  config = lib.mkIf config.programs.river.withUWSM {
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
