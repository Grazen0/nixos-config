{ config, pkgs, ... }:
{

  home.packages = with pkgs; [
    nodejs
    pnpm
  ];

  services.ssh-agent.enable = true;

  programs.fastfetch.enable = true;
  programs.htop.enable = true;
  programs.lazygit.enable = true;

  programs.btop = {
    enable = true;

    settings = {
      color_theme = "TTY";
      theme_background = false;
      vim_keys = true;
    };
  };

  programs.tmux = {
    enable = true;

    plugins = with pkgs.tmuxPlugins; [
      sensible
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
    ];

    terminal = "tmux-256color";
    shortcut = "a";
    baseIndex = 1;
    mouse = true;
    sensibleOnTop = true;
    secureSocket = true;

    extraConfig =
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

        # Other stuff
        set -g renumber-windows on
      '';
  };

  home.stateVersion = "24.05";
}
