{
  lib,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    file
    fd
    ripgrep
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

  console = {
    font = "${pkgs.terminus_font}/share/consolefonts/ter-v16b.psf.gz";
    keyMap = "us";
  };

  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };

    settings = {
      experimental-features = ["nix-command" "flakes"];
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

  nixpkgs.config.allowUnfree = true;
}
