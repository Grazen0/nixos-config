{pkgs, ...}: {
  imports = [
    ./cli.nix
    ./desktop-apps.nix
  ];

  home.packages = with pkgs; [
    wine
  ];
}
