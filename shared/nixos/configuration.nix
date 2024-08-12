{
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

  services = {
    printing.enable = true;
    libinput.enable = true;
    blueman.enable = true;
    gvfs.enable = true;
    tumbler.enable = true;

    pipewire = {
      enable = true;
      systemWide = true;
    };
  };

  programs = {
    zsh.enable = true;
    hyprland.enable = true;
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    WLR_NO_HARDWARE_CURSORS = "1";
  };

  security.polkit.enable = true;

  users = {
    defaultUserShell = pkgs.zsh;

    users.jdgt = {
      isNormalUser = true;
      extraGroups = ["wheel" "audio" "networkmanager"];
    };
  };

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "24.05";
}
