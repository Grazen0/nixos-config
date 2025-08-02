{ pkgs, inputs, ... }:
{
  home.packages = with pkgs; [
    # Desktop utilities
    pavucontrol
    file-roller
    gimp

    inputs.thorium-browser.defaultPackage.${pkgs.system}
    inkscape
    # insomnia
    obsidian
    zoom-us

    # Basic gaming
    wine64
    winetricks
    wl-clipboard
    # customPkgs.fceux
    # snes9x-gtk

    # LibreOffice + spellcheck
    libreoffice-qt
    hunspell
    hunspellDicts.en_US
    hunspellDicts.es_PE
  ];
}
