{
  pkgs,
  customPkgs,
  ...
}: {
  home.packages = with pkgs; [
    gcc
    cling

    gnumake
    cargo
    rustc
    clippy

    ghc

    jdk

    nodejs_22
    corepack_22

    # FIX: ehh
    ((python3.withPackages (ps:
        with ps; [
          numpy
          customPkgs.inkscape-figures
        ]))
      .overrideAttrs {
        # There's some other python3 collisioning with this,
        # but it's not in my config
        meta.priority = 1000;
      })
    (jupyter.override (prev: {
      definitions =
        (prev.definitions or {})
        // {
          custom-ir = {
            displayName = "R";
            argv = ["R" "--slave" "-e" "IRkernel::main()" "--args" "{connection_file}"];
            language = "R";
            # TODO: add logos
            logo32 = null;
            logo64 = null;
          };
        };
    }))
  ];
}
