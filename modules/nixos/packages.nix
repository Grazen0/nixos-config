{
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    home-manager

    # Apps
    ark
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
    inputs.thorium-browser.defaultPackage.${system}
    inputs.zen-browser.packages.${system}.specific

    # LibreOffice + spellcheck
    libreoffice-qt
    hunspell
    hunspellDicts.en_US
    hunspellDicts.es_PE

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
    cmake
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
