{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  programs.r = {
    enable = true;

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

    rstudio = {
      enable = true;
      package = pkgs.rstudioWrapper;

      preferences = {
        initial_working_directory = "~";
        editor_theme = "Kanagawa";
        editor_keybindings = "vim";
        new_proj_git_init = true;
        spelling_dictionary_language = "es_ES";

        highlight_selected_line = true;
        relative_line_numbers = true;
        show_margin = false;
        check_arguments_to_r_function_calls = true;
        warn_if_no_such_variable_in_scope = true;
        warn_variable_defined_but_not_used = true;
        terminal_bell_style = "none";
      };

      rPackages = with pkgs.rPackages; [
        stringi
        stringr
      ];

      themes.kanagawa = lib.readFile "${inputs.kanagawa-rstudio}/kanagawa.rstheme";
    };
  };
}
