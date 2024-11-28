{pkgs, ...}: {
  home.packages = with pkgs; [
    # Apps
    file-roller
    gimp
    inkscape
    kdenlive
    obsidian
    pavucontrol
    thorium-browser
    wdisplays
    zen-browser
    stable.zoom-us

    # LibreOffice + spellcheck
    libreoffice-qt
    hunspell
    hunspellDicts.en_US
    hunspellDicts.es_PE

    # Need this sometimes
    wine
  ];
}
