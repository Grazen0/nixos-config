{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [../../../shared/nixos/configuration.nix];

  networking.hostName = "nitori";
}
