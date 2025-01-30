{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # CLI utilities
    fd
    jq
    killall
    ripgrep
    unzip
    wget
  ];

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    liberation_ttf
    nerd-fonts.jetbrains-mono
  ];
}
