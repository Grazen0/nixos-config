{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # CLI utilities
    cbonsai
    cmatrix
    killall
    peaclock
    pipes-rs
    rmtrash
    trash-cli
    unzip
    wget

    # Gameing
    vitetris
    _2048-in-terminal
  ];
}
