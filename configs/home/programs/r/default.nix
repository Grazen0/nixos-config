{
  config,
  lib,
  lib',
  pkgs,
  customPkgs,
  inputs,
  ...
}:
{
  programs.r = {
    profile =
      let
        inherit (lib) concatStringsSep;
        inherit (lib') hexToRGB;

        ansiify =
          hex:
          let
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

    rPackages =
      with pkgs.rPackages;
      let
        inherit (pkgs) rPackages;
        inherit (rPackages) buildRPackage;

        colorout = buildRPackage {
          name = "colorout";
          src = inputs.colorout;
        };

      in
      [
        ggplot2
        dplyr
        readr
        psych
        corrplot
        scales
        tidyverse
        modeest
        quarto
        customPkgs.r-package-irkernel
        colorout
        languageserver
      ];

    rstudio = {
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
    };
  };
}
