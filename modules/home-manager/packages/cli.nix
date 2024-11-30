{pkgs, ...}: {
  home.packages = with pkgs; [
    customScripts.exe2png
    customScripts.make-writable
    cmatrix
    nitch
    rmtrash
    trash-cli
  ];
}
