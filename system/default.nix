{lib, ...}: {
  imports = [
    ./hardware
    ./programs
    ./services
    ./boot.nix
    ./console.nix
    ./laptop.nix
    ./network.nix
    ./nix.nix
    ./packages.nix
    ./security.nix
    ./users.nix
  ];

  time.timeZone = lib.mkDefault "America/Lima";
  i18n.defaultLocale = "en_US.UTF-8";

  services.xserver.displayManager.gdm = {
    enable = true;
    autoSuspend = false;
  };

  nixpkgs.config.allowUnfree = true;
}
