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
      version = "1.0.1-a.12";
    in {
      inherit version;
      src = builtins.fetchTarball {
        url = "https://github.com/zen-browser/desktop/releases/download/${version}/zen.linux-specific.tar.bz2";
        sha256 = "sha256:1b6klh9sf29kf5blyy2r1496gny6g70h2yfpyir79hxysabdf4qs";
      };
    }))

    # LibreOffice + spellcheck
    libreoffice-qt
    hunspell
    hunspellDicts.en_US
    hunspellDicts.es_PE
  ];
}
