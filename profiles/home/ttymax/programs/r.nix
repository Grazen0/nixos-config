{
  config,
  lib,
  lib',
  pkgs,
  inputs,
  ...
}: {
  programs.r = {
    profile = let
      inherit (lib) concatStringsSep;
      inherit (lib') hexToRGB;

      ansiify = hex: let
        rgb = hexToRGB hex;
      in
        "\\x1b[38;2;" + (concatStringsSep ";" (map toString rgb)) + "m";
    in
      with config.scheme;
      # r
        ''
          if (interactive() || isatty(stdout())) {
            options(colorout.verbose = 0)
            if (require("colorout", quietly = TRUE)) {
              colorout::setOutputColors(
                index    = "${ansiify base04}",
                normal   = "${ansiify base05}",
                number   = "${ansiify base06}",
                negnum   = "${ansiify base06}",
                zero     = "${ansiify base06}",
                infinite = "${ansiify yellow}",
                string   = "${ansiify green}",
                date     = "${ansiify magenta}",
                const    = "${ansiify yellow}",
                true     = "${ansiify bright-cyan}",
                false    = "${ansiify bright-cyan}",
                warn     = "${ansiify yellow}",
                stderror = "${ansiify red}",
                error    = "${ansiify red}",
                verbose  = FALSE
              )
            }

            options(browser = "xdg-open")
          }
        '';

    rPackages = with pkgs.rPackages; let
      inherit (pkgs) rPackages;
      inherit (rPackages) buildRPackage;

      grkstyle = buildRPackage {
        name = "grkstyle";
        src = inputs.grkstyle;
        propagatedBuildInputs = with rPackages; [
          magrittr
          purrr
          rlang
          rprojroot
          styler
        ];
      };

      r-nvim = buildRPackage {
        name = "r-nvim";
        src = inputs.r-nvim;
        propagatedBuildInputs = with rPackages; [
          styler
          grkstyle
        ];
      };

      colorout = buildRPackage {
        name = "colorout";
        src = inputs.colorout;
      };

      nvimcom = buildRPackage {
        name = "nvimcom";
        src = "${inputs.nvim-plugin-r-nvim}/nvimcom";
        propagatedBuildInputs = with rPackages; [
          knitr
          rmarkdown
          quarto
        ];
      };
    in [
      ggplot2
      dplyr
      readr
      psych
      corrplot
      scales
      tidyverse
      modeest
      quarto
      (IRkernel.overrideAttrs (oldAttrs: {
        patches = [./patches/irkernel.patch] ++ oldAttrs.patches or [];
      }))
      colorout
      r-nvim
      nvimcom
      languageserver
    ];
  };
}
