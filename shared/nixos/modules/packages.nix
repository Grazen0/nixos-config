{
  pkgs,
  inputs,
  ...
}: {
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    (nerdfonts.override {fonts = ["JetBrainsMono"];})
  ];

  environment.systemPackages = with pkgs; [
    home-manager

    # Apps
    ark
    brave
    vesktop
    gimp
    kitty
    matlab
    nsxiv
    obsidian
    pavucontrol
    spotify
    zapzap
    zoom-us

    # LibreOffice + spellcheck
    libreoffice-qt
    hunspell
    hunspellDicts.en_US
    hunspellDicts.es_PE

    # CLI utilities
    brightnessctl
    cbonsai
    cmatrix
    killall
    peaclock
    pipes-rs
    playerctl
    rmtrash
    trash-cli
    unzip
    wget

    # System/WM
    bemoji
    dex
    grim
    hyprpicker
    networkmanagerapplet
    polkit_gnome
    rofi-power-menu
    slurp
    wl-clipboard
    wtype

    # Codeing
    cargo
    cling
    gcc
    ghc
    go
    gnumake
    nodejs
    pnpm
    python3
    rustc
    yarn

    # Misc
    texlive.combined.scheme-medium
    vitetris
    _2048-in-terminal
  ];
}
