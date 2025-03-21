{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./aliases.nix
  ];

  # Handled by fzf-fish
  programs.fzf.enableFishIntegration = false;

  programs.fish = {
    enable = true;

    plugins =
      map (name: {
        inherit name;
        inherit (pkgs.fishPlugins.${name}) src;
      }) (
        [
          "autopair"
        ]
        ++ lib.optionals config.programs.fzf.enable ["fzf-fish"]
      );

    functions = {
      fish_mode_prompt.body = "";

      __fish_command_not_found_handler = {
        body = "__fish_default_command_not_found_handler $argv[1]";
        onEvent = "fish_command_not_found";
      };

      pythonenv = {
        argumentNames = "pythonVersion";
        body =
          # fish
          ''
            if set -q argv[2]
              set argv $argv[2..-1]
            end

            for el in $argv
              set ppkgs $ppkgs "python"$pythonVersion"Packages.$el"
            end

            nix-shell -p $ppkgs
          '';
      };

      nr = {
        argumentNames = "package";
        body = "nix run nixpkgs#$package $argv[2..-1]";
      };

      buildiso = {
        argumentNames = "packageName";
        body =
          # fish
          ''
            test -n "$packageName"; or set packageName "iso"
            nix build ".#nixosConfigurations."$packageName".config.system.build.isoImage"
          '';
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
        set fish_color_selection brwhite --background ${config.theme.colors.hex.highlight}

        # Bindings
        fish_vi_key_bindings
        for mode in normal insert
          bind -M $mode ctrl-space 'accept-autosuggestion'
          bind -M $mode ctrl-p 'history-prefix-search-backward'
          bind -M $mode ctrl-n 'history-prefix-search-forward'
          bind -M $mode ctrl-z 'fg &> /dev/null; commandline -f repaint'
        end
      '';
  };
}
