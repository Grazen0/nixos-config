{
  pkgs,
  customPkgs,
  inputs,
  ...
}:
{
  home.packages = with pkgs; [
    # Desktop utilities
    pavucontrol
    file-roller
    gimp
    wdisplays

    inputs.thorium-browser.defaultPackage.${pkgs.system}
    audacity
    inkscape
    # insomnia
    obsidian
    customPkgs.zoom-us
    postman

    # Basic gaming
    wine
    # customPkgs.fceux
    # snes9x-gtk

    # LibreOffice + spellcheck
    libreoffice-qt
    hunspell
    hunspellDicts.en_US
    hunspellDicts.es_PE
  ];
}
