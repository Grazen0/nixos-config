{
  config,
  pkgs,
  stablePkgs,
  inputs,
  ...
}: {
  programs.tmux = {
    enable = true;

    plugins = with pkgs.tmuxPlugins; let
      stablePlugins = stablePkgs.tmuxPlugins;

      kanagawa = mkTmuxPlugin {
        version = "master";
        src = inputs.tmux-plugin-kanagawa;

        pluginName = "kanagawa";
        rtpFilePath = "kanagawa.tmux";
      };
    in
      with pkgs.tmuxPlugins; [
        sensible
        vim-tmux-navigator
        yank
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
              set -g @kanagawa-show-left-sep 
              set -g @kanagawa-show-right-sep 
            '';
        }
        {
          plugin = stablePlugins.resurrect;
          extraConfig =
            # tmux
            ''
              set -g @resurrect-capture-pane-contents 'on'
              set -g @resurrect-strategy-nvim 'session'

              # https://github.com/tmux-plugins/tmux-resurrect/issues/247#issuecomment-2387643976
              resurrect_dir="${config.xdg.dataHome}/tmux/resurrect"
              set -g @resurrect-dir "$resurrect_dir"
              set -g @resurrect-hook-post-save-all "sed -i 's| --cmd .*-vim-pack-dir||g; s|/etc/profiles/per-user/$USER/bin/||g; s|/nix/store/.*/bin/||g' $(readlink -f $resurrect_dir/last)"
            '';
        }
        {
          plugin = continuum;
          extraConfig =
            # tmux
            ''
              set -g @continuum-restore 'on'
              set -g @continuum-boot 'on'
              set -g @continuum-save-interval '5'
            '';
        }
      ];

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

        set-window-option -g mode-keys vi

        bind-key -T copy-mode-vi v send-keys -X begin-selection
        bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
        bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel
      '';
  };
}
