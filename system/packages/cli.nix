{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # CLI utilities
    fd
    jq
    killall
    ripgrep
    socat
    unzip
    wget
  ];
}
