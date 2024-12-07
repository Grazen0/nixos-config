{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./aliases.nix
  ];

  # Required for fzf.fish
  home.packages = with pkgs; [fzf];

  programs.fish = {
    enable = true;

    plugins =
      map (name: {
        inherit name;
        inherit (pkgs.fishPlugins.${name}) src;
      }) [
        "autopair"
        "fzf-fish"
      ];

    functions = {
      fish_mode_prompt.body = "";

      __fish_command_not_found_handler = {
        body = "__fish_default_command_not_found_handler $argv[1]";
        onEvent = "fish_command_not_found";
      };
    };

    interactiveShellInit = ''
      source ${inputs.aphrodite-terminal-theme}/fish_prompt.fish

      # Disable greeting message
      set -U fish_greeting

      # Vi cursor stuff
      set fish_cursor_default block
      set fish_cursor_insert line
      set fish_cursor_replace_one underscore
      set fish_cursor_visual block

      # Colors
      set fish_color_command green
      set fish_color_error red
      set fish_color_cancel black --background red
      set fish_color_selection brwhite --background ${config.theme.colors.hex.highlight}

      # Bindings
      fish_vi_key_bindings
      for mode in normal insert
        bind -M $mode -k nul 'accept-autosuggestion'
        bind -M $mode \cp 'history-prefix-search-backward'
        bind -M $mode \cn 'history-prefix-search-forward'
        bind -M $mode \cz 'fg &> /dev/null'
      end
    '';
  };
}
