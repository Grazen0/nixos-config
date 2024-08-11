{
  imports = [
    ./hardware-configuration.nix
    ../../../shared/nixos/configuration.nix
  ];

  networking.hostName = "takane";
}
