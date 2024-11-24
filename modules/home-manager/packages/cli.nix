{pkgs, ...}: {
  home.packages = with pkgs; [
    customScripts.exe2png
    cmatrix
    nitch
    rmtrash
    trash-cli
  ];
}
