{ config, pkgs, ... }:
{
  imports = [
    ../ttymax
    ./services
  ];

  # Font packages
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    liberation_ttf
    nerd-fonts.commit-mono
    nerd-fonts.comic-shanns-mono
  ];

  # Required for some things to work properly
  security = {
    polkit.enable = true;
    rtkit.enable = true;
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  programs = {
    dconf.enable = true;

    hyprland = {
      enable = true;
      withUWSM = true;
    };

    river = {
      enable = false;
      withUWSM = true;
      extraPackages = [ ]; # Would install waybar, foot and dmenu for some reason
    };

    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-media-tags-plugin
        thunar-volman
      ];
    };
  };

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  boot = {
    # v4l2loopback module required for OBS Virtual Camera
    extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];
    kernelModules = [ "v4l2loopback" ];
    extraModprobeConfig = ''
      options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
    '';
  };
}
