{
  pkgs ? import <nixpkgs> {},
  inputs,
  ...
}: let
  inherit (pkgs) callPackage;
  callPy3Package = pkgs.python3Packages.callPackage;

  ppick = inputs.ppick.packages.${pkgs.system}.default;
in rec {
  # Existing packages
  menu-qalc = callPackage ./menu-qalc.nix {src = inputs.menu-qalc;};

  # Python packages
  inkscape-figures = callPy3Package ./python/inkscape-figures.nix {src = inputs.inkscape-figures;};

  # My own stuff
  exe2png = callPackage ./scripts/exe2png.nix {};
  fuzzel-power-menu = callPackage ./scripts/fuzzel-power-menu.nix {};
  handle-monitor-connect = callPackage ./scripts/handle-monitor-connect.nix {};
  make-writable = callPackage ./scripts/make-writable.nix {};
  wlr-randr-all = callPackage ./scripts/wlr-randr-all.nix {};
  volume-update = callPackage ./scripts/volume-update.nix {};
  player-art = callPackage ./scripts/player-art.nix {};
  tmux-music = callPackage ./scripts/tmux/music.nix {inherit player-art;};
  tmux-session-picker = callPackage ./scripts/tmux/session-picker.nix {inherit ppick;};
  waybar-notifications-state = callPackage ./scripts/waybar/notifications-state.nix {};
  waybar-media-query = callPackage ./scripts/waybar/media-query.nix {};
}
