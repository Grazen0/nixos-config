{
  lib,
  pkgs,
  inputs,
  theme,
  ...
}: let
  inherit (inputs) spicetify-nix;
  spicePkgs = spicetify-nix.legacyPackages.${pkgs.system};
in {
  imports = [spicetify-nix.homeManagerModules.default];

  programs.spicetify = {
    enable = lib.mkDefault true;

    theme =
      spicePkgs.themes.text
      // {
        additionalCss = ''
          :root {
            --font-family: "${theme.font.propo}", monospace !important;
            --border-width: 2px !important;
            letter-spacing: -0.075ch !important;
          }
        '';
      };

    colorScheme = "kanagawa";

    enabledExtensions = with spicePkgs.extensions; [
      adblock
      shuffle
      keyboardShortcut
    ];
  };
}
