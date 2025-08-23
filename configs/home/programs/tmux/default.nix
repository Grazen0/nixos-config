{
  config,
  pkgs,
  customPkgs,
  ...
}:
{
  programs.tmux = {
    plugins = with pkgs.tmuxPlugins; [
      sensible
      vim-tmux-navigator
      yank
      better-mouse-mode
      {
        plugin = resurrect;
        extraConfig =
          # tmux
          ''
            set -g @resurrect-strategy-nvim 'session'
            set -g @resurrect-dir "${config.xdg.dataHome}/tmux/resurrect"
            set -g @resurrect-processes 'false'
          '';
      }
      {
        plugin = continuum;
        extraConfig =
          # tmux
          ''
            set -g @continuum-restore 'on'
            set -g @continuum-boot 'on'
          '';
      }
    ];

    terminal = "tmux-256color";
    shortcut = "a";
    baseIndex = 1;
    mouse = true;
    sensibleOnTop = true;
    secureSocket = true;

    extraConfig =
      let
        session-picker = "${customPkgs.tmux-session-picker}/bin/tmux-session-picker";
      in
      # tmux
      ''
        # Pane navigation with hjkl
        bind h select-pane -L
        bind j select-pane -D
        bind k select-pane -U
        bind l select-pane -R

        # Resize panes with hjkl
        bind -r C-h resize-pane -L
        bind -r C-j resize-pane -D
        bind -r C-k resize-pane -U
        bind -r C-l resize-pane -R

        # Nicer split commands
        bind | split-window -h -c "#{pane_current_path}"
        bind - split-window -v -c "#{pane_current_path}"

        set-window-option -g mode-keys vi

        bind-key -T copy-mode-vi v send-keys -X begin-selection
        bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
        bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel

        # Awesome session picker
        bind o run-shell "${session-picker}"

        # Lazygit binding
        bind g display-popup -E -w 90% -h 90% -S 'fg=brightblack' -d '#{pane_current_path}' lazygit

        # Other stuff
        set -g popup-border-style fg=white
        set -g renumber-windows on

        # Style
        set -g status-position top
        set -g status-justify absolute-centre
        set -g status-style 'fg=white bg=default'
        set -g status-left ' [#S] '
        set -g status-left-length 100
        set -g status-left-style 'fg=brightblack'
        set -g status-right '  #(git -C "#{pane_current_path}" rev-parse --abbrev-ref HEAD) '
        set -g status-right-length 100
        setw -g window-status-current-style 'fg=cyan bg=default bold'
        setw -g window-status-style 'fg=brightblack'
      '';
  };
}
