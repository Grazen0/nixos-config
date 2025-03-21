{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  programs.r = {
    profile = let
      colors = lib.mapAttrs (_: rgb:
        "\\x1b[38;2;"
        + (lib.concatStringsSep ";" (map toString rgb))
        + "m")
      config.theme.colors.rgb;
    in
      # r
      ''
        if (interactive() || isatty(stdout())) {
          options(colorout.verbose = 0)
          if (require("colorout", quietly = TRUE)) {
            colorout::setOutputColors(
              index    = "${colors.brightBlack}",
              normal   = "${colors.foreground}",
              number   = "${colors.white}",
              negnum   = "${colors.white}",
              zero     = "${colors.white}",
              infinite = "${colors.yellow}",
              string   = "${colors.green}",
              date     = "${colors.magenta}",
              const    = "${colors.yellow}",
              true     = "${colors.brightCyan}",
              false    = "${colors.brightCyan}",
              warn     = "${colors.brightYellow}",
              stderror = "${colors.red}",
              error    = "${colors.red}",
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
