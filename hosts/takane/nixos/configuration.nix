{outputs, ...}: {
  imports = [
    outputs.nixosModules
    ./hardware-configuration.nix
    ./modules
  ];

  programs.steam.enabled = false;

  system.stateVersion = "24.05";
}
