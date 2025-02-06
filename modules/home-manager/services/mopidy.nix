{
  config,
  lib,
  customPkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkPackageOption mkIf;
  cfg = config.services.mopidy;
in {
  options.services.mopidy = {
    discord-rpc = {
      enable = mkEnableOption "mopidy-discord-rpc";
      package = mkPackageOption customPkgs "mopidy-discord-rpc" {};
    };
  };

  config = mkIf cfg.enable {
    systemd.user.services.mopidy-discord-rpc = mkIf cfg.discord-rpc.enable {
      Unit = {
        Description = "Discord RPC for Mopidy";
        After = ["network.target" "mopidy.service"];
      };

      Service = {
        ExecStart = "${cfg.discord-rpc.package}/bin/mopidy-discord-rpc";
        Restart = "on-failure";
      };

      Install.WantedBy = ["default.target"];
    };
  };
}
