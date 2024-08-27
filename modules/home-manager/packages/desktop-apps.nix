{
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
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
  ];
}
