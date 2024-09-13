{pkgs, ...}: {
  home.packages = with pkgs; [
    cbonsai
    cmatrix
    pipes-rs
    rmtrash
    trash-cli

    # Gameing
    vitetris
    _2048-in-terminal
  ];
}
