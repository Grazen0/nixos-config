{pkgs, ...}: {
  home.packages = with pkgs; [
    cbonsai
    cmatrix
    fortune
    peaclock
    pipes-rs
    rmtrash
    trash-cli

    # Gameing
    vitetris
    _2048-in-terminal
  ];
}
