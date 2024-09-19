{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # CLI utilities
    jq
    killall
    socat
    unzip
    wget
  ];
}
