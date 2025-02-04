{
  pkgs ? import <nixpkgs> {},
  inputs,
  ...
}: let
  inherit (pkgs) callPackage;
  callPy3Package = pkgs.python3Packages.callPackage;
in rec {
  # Existing packages
  menu-qalc = callPackage ./menu-qalc.nix {src = inputs.menu-qalc;};

  # Python packages
  inkscape-figures = callPy3Package ./python/inkscape-figures.nix {src = inputs.inkscape-figures;};
  mdformat-ruff = callPy3Package ./python/mdformat-ruff.nix {src = inputs.mdformat-ruff;};
  mdformat-web = callPy3Package ./python/mdformat-web.nix {src = inputs.mdformat-web;};
  mdformat-wikilink = callPy3Package ./python/mdformat-wikilink.nix {src = inputs.mdformat-wikilink;};
  mdformat-obsidian = callPy3Package ./python/mdformat-obsidian.nix {
    inherit mdformat-ruff mdformat-web mdformat-wikilink;
    src = inputs.mdformat-obsidian;
  };

  # My own stuff
  close-window = callPackage ./scripts/close-window.nix {};
  exe2png = callPackage ./scripts/exe2png.nix {};
  fuzzel-power-menu = callPackage ./scripts/fuzzel-power-menu.nix {};
  handle-monitor-connect = callPackage ./scripts/handle-monitor-connect.nix {};
  make-writable = callPackage ./scripts/make-writable.nix {};
  wlr-randr-all = callPackage ./scripts/wlr-randr-all.nix {};
  volume-update = callPackage ./scripts/volume-update.nix {};

  waybar-dunst-state = callPackage ./waybar/dunst-state.nix {};
  waybar-media-query = callPackage ./waybar/media-query.nix {};
}
