{
  pkgs ? import <nixpkgs> {},
  inputs,
  ...
}: rec {
  # Existing packages
  menu-qalc = pkgs.callPackage ./menu-qalc.nix {src = inputs.menu-qalc;};

  # Python packages
  inkscape-figures = pkgs.python3Packages.callPackage ./inkscape-figures.nix {src = inputs.inkscape-figures;};
  mdformat-ruff = pkgs.python3Packages.callPackage ./mdformat-ruff.nix {src = inputs.mdformat-ruff;};
  mdformat-web = pkgs.python3Packages.callPackage ./mdformat-web.nix {src = inputs.mdformat-web;};
  mdformat-wikilink = pkgs.python3Packages.callPackage ./mdformat-wikilink.nix {src = inputs.mdformat-wikilink;};
  mdformat-obsidian = pkgs.python3Packages.callPackage ./mdformat-obsidian.nix {
    inherit mdformat-ruff mdformat-web mdformat-wikilink;
    src = inputs.mdformat-obsidian;
  };

  # My own stuff
  close-window = pkgs.callPackage ./close-window.nix {};
  exe2png = pkgs.callPackage ./exe2png.nix {};
  fuzzel-power-menu = pkgs.callPackage ./fuzzel-power-menu.nix {};
  handle-monitor-connect = pkgs.callPackage ./handle-monitor-connect.nix {};
  make-writable = pkgs.callPackage ./make-writable.nix {};
  volume-update = pkgs.callPackage ./volume-update.nix {};
  waybar-dunst-state = pkgs.callPackage ./waybar-dunst-state.nix {};
  waybar-media-query = pkgs.callPackage ./waybar-media-query.nix {};
}
