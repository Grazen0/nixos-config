{lib, ...}: {
  imports = [
    ./hardware
    ./packages
    ./programs
    ./boot.nix
    ./console.nix
    ./laptop.nix
    ./network.nix
    ./nix.nix
    ./security.nix
    ./services.nix
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
