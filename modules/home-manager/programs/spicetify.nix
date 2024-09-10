{
  pkgs,
  inputs,
  ...
}: let
  inherit (inputs) spicetify-nix;
  spicePkgs = spicetify-nix.legacyPackages.${pkgs.system};
in {
  imports = [spicetify-nix.homeManagerModules.default];

  programs.spicetify = {
    enable = true;

    theme =
      spicePkgs.themes.text
      // {
        additionalCss = ''
          :root {
            --font-family: "JetBrainsMonoNL Nerd Font Propo", monospace !important;
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
