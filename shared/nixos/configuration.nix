flake-overlays: {
  config,
  lib,
  pkgs,
  host,
  ...
}: {
  imports = [./modules];

  networking = {
    hostName = host;
    networkmanager.enable = true;
  };

  time.timeZone = "America/Lima";
  i18n.defaultLocale = "en_US.UTF-8";

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    WLR_NO_HARDWARE_CURSORS = "1";
  };

  security = {
    polkit.enable = true;
    rtkit.enable = true;
  };

  users = {
    defaultUserShell = pkgs.zsh;

    users.jdgt = {
      isNormalUser = true;
      extraGroups = ["wheel" "audio" "networkmanager"];
    };
  };

  system.stateVersion = "24.05";

  nixpkgs.overlays = flake-overlays;
}
