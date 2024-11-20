{pkgs, ...}: {
  home.packages = with pkgs; [
    cmatrix
    nitch
    rmtrash
    trash-cli
  ];
}
