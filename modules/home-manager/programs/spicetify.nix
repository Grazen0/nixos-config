{
  pkgs,
  inputs,
  ...
}: let
  inherit (inputs) spicetify-nix;
  spicePkgs = spicetify-nix.legacyPackages.${pkgs.system};
in {
  imports = [
    spicetify-nix.homeManagerModules.default
  ];

  programs.spicetify = {
    enable = true;
    theme = spicePkgs.themes.text;
    colorScheme = "kanagawa";

    enabledExtensions = with spicePkgs.extensions; [
      adblock
      hidePodcasts
      shuffle
    ];
  };
}
