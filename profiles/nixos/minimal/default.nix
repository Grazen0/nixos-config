{ lib, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    file
    fd
    ripgrep
    zip
    unzip
    wget
    man-pages
    man-pages-posix
  ];

  time.timeZone = lib.mkDefault "America/Lima";
  i18n.defaultLocale = "en_US.UTF-8";

  networking = {
    networkmanager.enable = true;
    firewall.enable = true;
    nftables.enable = true;
  };

  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };

    settings = {
      trusted-users = [ "jdgt" ];
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
  };

  boot.loader = {
    systemd-boot = {
      enable = true;
      configurationLimit = 10;
      editor = false;
    };

    efi.canTouchEfiVariables = true;
    timeout = 5;
  };

  hardware.enableAllFirmware = true;

  nixpkgs.config.allowUnfree = true;
}
