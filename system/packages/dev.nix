{
  pkgs,
  customPkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    cargo
    cling
    clippy
    gcc
    ghc
    gnumake
    jdk
    nodejs_22
    corepack_22
    # (jupyter.override (prev: {
    #   definitions =
    #     (prev.definitions or {})
    #     // {
    #       ir = {
    #         displayName = "R";
    #         argv = ["R" "--slave" "-e" "IRkernel::main()" "--args" "{connection_file}"];
    #         language = "R";
    #         # TODO: add logos
    #         logo32 = null;
    #         logo64 = null;
    #       };
    #     };
    # }))
    jupyter
    (python3.withPackages
      (ps:
        with ps; [
          customPkgs.inkscape-figures
        ]))
    rustc
  ];
}
