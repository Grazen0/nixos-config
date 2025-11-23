{
  config,
  pkgs,
  inputs,
  ...
}:
let
  inherit (inputs) spicetify-nix;
  spicePkgs = spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in
{
  imports = [ spicetify-nix.homeManagerModules.default ];

  programs.spicetify = {
    theme = spicePkgs.themes.text // {
      additionalCss = ''
        :root {
          --font-family: "${config.theme.font.propo}", monospace !important;
          --border-width: 2px !important;
          letter-spacing: -0.075ch !important;
        }
      '';
    };

    colorScheme = "Kanagawa";

    enabledExtensions = with spicePkgs.extensions; [
      adblock
      shuffle
      keyboardShortcut
    ];
  };
}
