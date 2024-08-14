{pkgs, ...}: {
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    (nerdfonts.override {fonts = ["JetBrainsMono"];})
  ];

  environment.systemPackages = with pkgs; [
    home-manager

    # Apps
    ark
    vesktop
    gimp
    kitty
    nsxiv
    obsidian
    pavucontrol
    spotify
    vscode
    zoom-us

    # LibreOffice + spellcheck
    libreoffice-qt
    hunspell
    hunspellDicts.en_US
    hunspellDicts.es_PE

    # CLI utilities
    brightnessctl
    btop
    cmatrix
    eza
    fd
    killall
    peaclock
    pipes-rs
    playerctl
    ripgrep
    rmtrash
    trash-cli
    unzip
    wget

    # System/WM
    cliphist
    dex
    grim
    hyprpicker
    networkmanagerapplet
    polkit_gnome
    rofi-power-menu
    rofimoji
    slurp
    wl-clipboard

    # Codeing
    gcc
    gnumake
    nodejs
    cargo
    python3
    rustc
    go

    # Misc
    texlive.combined.scheme-medium
    vitetris
    _2048-in-terminal
  ];
}
