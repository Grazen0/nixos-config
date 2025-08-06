{ pkgs, ... }:
{
  programs.r.rstudio = {
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
}
