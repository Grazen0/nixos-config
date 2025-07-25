{
  imports = [
    ./hardware-configuration.nix
  ];

  networking.hostName = "shinmy";
  system.stateVersion = "24.05";
}
