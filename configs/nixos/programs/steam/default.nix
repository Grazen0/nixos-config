{
  config,
  lib,
  pkgs,
  ...
}:
{

  environment.systemPackages = lib.optionals config.programs.steam.enable (with pkgs; [ steam-run ]);

  programs.steam = {
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };
}
