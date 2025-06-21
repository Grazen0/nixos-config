{
  config,
  pkgs,
  customPkgs,
  ...
}:
{
  programs.tmux = {
    enable = true;

    plugins = with pkgs.tmuxPlugins; [
      sensible
      vim-tmux-navigator
      yank
      better-mouse-mode
      {
        plugin = kanagawa;
        extraConfig =
          # tmux
          ''
            set -g @kanagawa-ignore-window-colors true
            set -g @kanagawa-plugins "cwd git time"
            set -g @kanagawa-show-timezone false
            set -g @kanagawa-git-disable-status true

            set -g @kanagawa-show-powerline true
            set -g @kanagawa-show-left-sep " "
            set -g @kanagawa-show-right-sep " "
          '';
      }
      {
        plugin = resurrect;
        extraConfig =
          # tmux
          ''
            set -g @resurrect-capture-pane-contents 'on'
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

        # https://reddit.com/r/tmux/comments/mesrci/tmux_2_doesnt_seem_to_use_256_colors/
        set -ga terminal-overrides ",*256col*:Tc"
        set -ga terminal-overrides '*:Ss=\E[%p1%d q:Se=\E[ q'
        set-environment -g COLORTERM "truecolor"

        # Open panes in current directory
        bind % split-window -h -c "#{pane_current_path}"
        bind '"' split-window -v -c "#{pane_current_path}"

        # Also better split commands
        bind | split-window -h -c "#{pane_current_path}"
        bind - split-window -v -c "#{pane_current_path}"

        # Session select start at index 1
        # https://unix.stackexchange.com/questions/313577/how-to-make-tmux-sessions-count-from-1-instead-of-0/755474#755474
        bind-key s choose-tree -ZsK '#{?#{e|<:#{line},9},#{e|+:1,#{line}},#{?#{e|<:#{line},35},M-#{a:#{e|+:97,#{e|-:#{line},9}}},}}'

        set-window-option -g mode-keys vi

        bind-key -T copy-mode-vi v send-keys -X begin-selection
        bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
        bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel

        # Awesome session picker
        bind o run-shell "${session-picker}"

        # Other stuff
        set -g popup-border-style fg=white
        set -g renumber-windows on
      '';
  };
}
