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
    nsxiv
    obsidian
    pavucontrol
    zoom-us
    inputs.thorium-browser.defaultPackage.${system}
    (inputs.zen-browser.packages.${system}.specific.overrideAttrs (prev: let
      version = "1.0.1-a.10";
    in {
      inherit version;
      src = builtins.fetchTarball {
        url = "https://github.com/zen-browser/desktop/releases/download/${version}/zen.linux-specific.tar.bz2";
        sha256 = "sha256:1iwqfz9hmkmg0b57w8928hfmav1lyxq29dfp0q029m2cb40ypmk4";
      };
    }))

    # LibreOffice + spellcheck
    libreoffice-qt
    hunspell
    hunspellDicts.en_US
    hunspellDicts.es_PE
  ];
}
