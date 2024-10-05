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
      version = "1.0.1-a.7";
    in {
      inherit version;
      src = builtins.fetchTarball {
        url = "https://github.com/zen-browser/desktop/releases/download/${version}/zen.linux-specific.tar.bz2";
        sha256 = "sha256:1dlb2cl86ndsl6b6jv7qr7rdg2rzqjgn3y8rlw6d8jj5r0giyinh";
      };
    }))

    # LibreOffice + spellcheck
    libreoffice-qt
    hunspell
    hunspellDicts.en_US
    hunspellDicts.es_PE
  ];
}
