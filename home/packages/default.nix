{pkgs, ...}: {
  imports = [
    ./cli.nix
    ./graphical.nix
    ./dev.nix
  ];

  home.packages = with pkgs; [
    wine
  ];
}
