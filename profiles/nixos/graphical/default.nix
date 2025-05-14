{ config, pkgs, ... }:
{
  imports = [
    ../ttymax
    ./services.nix
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

    river = {
      enable = true;
      withUWSM = true;
      # Would install waybar, foot and dmenu for some reason
      extraPackages = [ ];
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

  console.colors = with config.scheme; [
    base01
    red
    green
    yellow
    blue
    magenta
    cyan
    base06
    base04
    bright-red
    bright-green
    yellow
    bright-blue
    bright-magenta
    bright-cyan
    base05
  ];

  boot = {
    # plymouth.enable = true;

    # Silent boot
    # consoleLogLevel = 0;
    # initrd.verbose = false;
    # kernelParams = [
    #   "quiet"
    #   "splash"
    #   "boot.shell_on_fail"
    #   "loglevel=3"
    #   "rd.systemd.show_status=false"
    #   "rd.udev.log_level=3"
    #   "udev.log_priority=3"
    # ];

    # v4l2loopback module required for OBS Virtual Camera
    extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];
    kernelModules = [ "v4l2loopback" ];
    extraModprobeConfig = ''
      options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
    '';
  };
}
