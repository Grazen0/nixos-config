{
  lib,
  pkgs,
  inputs,
  ...
}: {
  programs.r = {
    enable = true;

    profile =
      # r
      ''
        # TODO: follow setup from https://github.com/jalvesaq/colorout
        library(colorout)
      '';

    rPackages = with pkgs.rPackages; let
      inherit (pkgs.rPackages) buildRPackage;

      grkstyle = buildRPackage {
        name = "grkstyle";
        src = inputs.grkstyle;
        propagatedBuildInputs = with pkgs.rPackages; [
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
        propagatedBuildInputs = with pkgs.rPackages; [
          styler
          grkstyle
        ];
      };

      colorout = buildRPackage {
        name = "colorout";
        src = inputs.colorout;
      };
    in [
      ggplot2
      dplyr
      readr
      psych
      corrplot
      scales
      quarto
      colorout
      r-nvim
    ];

    rstudio = {
      enable = true;

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
