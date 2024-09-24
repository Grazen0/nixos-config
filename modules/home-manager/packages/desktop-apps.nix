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
      version = "1.0.1-a.4";
    in {
      inherit version;
      src = builtins.fetchTarball {
        url = "https://github.com/zen-browser/desktop/releases/download/${version}/zen.linux-specific.tar.bz2";
        sha256 = "0jjfr1201gfw0cy8q1jbr504994z33sbw8ip86c6xbww8qm60bqh";
      };
    }))

    # LibreOffice + spellcheck
    libreoffice-qt
    hunspell
    hunspellDicts.en_US
    hunspellDicts.es_PE
  ];
}
