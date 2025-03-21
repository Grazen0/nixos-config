{pkgs, ...}: {
  imports = [
    ./dev.nix
  ];

  home.packages = with pkgs; [
    pciutils
    cmatrix
    nitch
  ];
}
