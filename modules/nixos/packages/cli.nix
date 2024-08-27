{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # CLI utilities
    killall
    unzip
    wget
  ];
}
