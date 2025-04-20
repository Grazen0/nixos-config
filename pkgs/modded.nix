{ pkgs, inputs, ... }:
let
  zoomPkgs = import inputs.nixpkgs-zoom {
    inherit (pkgs) system;
    config.allowUnfree = true;
  };
in
{
  inherit (zoomPkgs) zoom-us;

  ristate = pkgs.ristate.override (prev: {
    rustPlatform = prev.rustPlatform // {
      buildRustPackage =
        args:
        prev.rustPlatform.buildRustPackage (
          args
          // {
            src = inputs.ristate;
            cargoHash = "sha256-6uvIc69x/yHkAC3GJUuYGcCbpVyX/mb/pXLf+BQC+48=";
          }
        );
    };
  });

  fceux = pkgs.fceux.overrideAttrs (prev: {
    postInstall = ''
      ${prev.postInstall or ""}

      substituteInPlace "$out/share/applications/fceux.desktop" \
        --replace-fail "/usr" "$out"
    '';
  });

  vim-plugin-haskell-tools-nvim = pkgs.vimPlugins.haskell-tools-nvim.overrideAttrs (prev: {
    patches = [ ./patches/haskell-tools.patch ] ++ (prev.patches or [ ]);
  });

  r-package-irkernel = pkgs.rPackages.IRkernel.overrideAttrs (prev: {
    patches = [ ./patches/irkernel.patch ] ++ (prev.patches or [ ]);
  });
}
