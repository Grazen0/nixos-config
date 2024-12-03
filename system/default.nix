{
  imports = [
    ./hardware
    ./packages
    ./programs
    ./boot.nix
    ./console.nix
    ./laptop.nix
    ./locale.nix
    ./networking.nix
    ./nix.nix
    ./security.nix
    ./services.nix
    ./users.nix
  ];

  nixpkgs.config.allowUnfree = true;
}
