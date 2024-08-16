{
  pkgs,
  inputs,
  ...
}: {
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    (nerdfonts.override {fonts = ["JetBrainsMono"];})
  ];

  environment.systemPackages = with pkgs; [
    home-manager

    # Apps
    inputs.thorium-browser.defaultPackage.${system}
    ark
    vesktop
    gimp
    kitty
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
    btop
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
    pnpm
    python3
    rustc
    ghc
    go
    yarn

    # Misc
    texlive.combined.scheme-medium
    vitetris
    _2048-in-terminal
  ];
}
