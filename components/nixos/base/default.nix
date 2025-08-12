{ pkgs, ... }:
{
  networking.networkmanager.enable = true;
  networking.firewall.enable = true;
  networking.nftables.enable = true;

  hardware.enableAllFirmware = true;

  boot.loader = {
    systemd-boot = {
      enable = true;
      configurationLimit = 10;
      editor = false;
    };

    efi.canTouchEfiVariables = true;
    timeout = 5;
  };

  time.timeZone = "America/Lima";
  i18n.defaultLocale = "en_US.UTF-8";

  environment.systemPackages = with pkgs; [
    fd
    file
    lsof
    man-pages
    man-pages-posix
    ripgrep
    unzip
    wget
    zip
  ];

  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };

    settings = {
      trusted-users = [ "@wheel" ];
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
  };

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowBroken = true;
}
