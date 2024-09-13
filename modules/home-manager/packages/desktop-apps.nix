{
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    # Apps
    ark
    gimp
    inkscape
    kitty
    nsxiv
    obsidian
    pavucontrol
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
