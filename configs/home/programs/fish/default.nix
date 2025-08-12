{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
{
  imports = [ ./aliases.nix ];

  # See https://nixos.wiki/wiki/Fish#Setting_fish_as_your_shell
  programs.bash = lib.mkIf config.programs.fish.enable {
    enable = true;
    initExtra = ''
      if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
      then
        shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
        exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
      fi
    '';
  };

  programs.fish = {
    plugins = with pkgs; [
      {
        name = "autopair";
        src = fishPlugins.autopair;
      }
    ];

    functions = {
      fish_mode_prompt.body = "";

      __fish_command_not_found_handler = {
        body = "__fish_default_command_not_found_handler $argv[1]";
        onEvent = "fish_command_not_found";
      };

      nr = {
        argumentNames = "package";
        body = "nix run nixpkgs#$package $argv[2..-1]";
      };
    };

    interactiveShellInit =
      # fish
      ''
        # Environment variables
        set -x APHRODITE_THEME_SHOW_TIME yes

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
        set fish_color_selection brwhite --background ${config.scheme.base02}

        # Bindings
        fish_vi_key_bindings
        for mode in normal insert
          bind -M $mode ctrl-space 'accept-autosuggestion'
          bind -M $mode ctrl-p 'history-prefix-search-backward'
          bind -M $mode ctrl-n 'history-prefix-search-forward'
        end
      '';
  };
}
