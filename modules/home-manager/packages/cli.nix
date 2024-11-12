{pkgs, ...}: {
  home.packages = with pkgs; [
    cmatrix
    rmtrash
    trash-cli

    # Gameing
    vitetris
    _2048-in-terminal
  ];
}
