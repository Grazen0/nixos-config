{
  pkgs,
  customPkgs,
  ...
}:
pkgs.writeShellApplication {
  name = "tmux-music";
  runtimeInputs = [customPkgs.player-art];
  text = ''
    if [[ $# -ne 1 ]]; then
      echo "Usage: tmux-music [DEFAULT_IMAGE]"
      exit 1
    fi

    DEFAULT_IMG="$1"
    SESSION="music"

    if tmux has-session -t "$SESSION" &>/dev/null; then
      tmux attach-session -t "$SESSION"
      exit
    fi

    visualizer=$(tmux new-session -d -s "$SESSION" -P -F "#{pane_id}")

    # Open panes
    playlist=$(tmux split-window -v -l 22 -P -F "#{pane_id}")
    browser=$(tmux split-window -h -P -F "#{pane_id}")
    search=$(tmux split-window -h -P -F "#{pane_id}")
    tmux split-window -h -b -t "$visualizer" -l 56 "player-art '$DEFAULT_IMG'"

    # Open stuff
    tmux send-keys -t "$visualizer" "ncmpcpp -s visualizer -c '$XDG_CONFIG_HOME/ncmpcpp/visualizer'" C-m
    sleep 0.25 # The visualizer won't start otherwise for some reason
    tmux send-keys -t "$playlist" "ncmpcpp -s playlist -c '$XDG_CONFIG_HOME/ncmpcpp/minimal'" C-m
    tmux send-keys -t "$browser" "ncmpcpp -s browser -c '$XDG_CONFIG_HOME/ncmpcpp/minimal'" C-m
    tmux send-keys -t "$search" "ncmpcpp -s search_engine -c '$XDG_CONFIG_HOME/ncmpcpp/minimal'" C-m

    # Resize panes
    tmux resize-pane -t "$playlist" -x 76
    tmux resize-pane -t "$browser" -x 68

    # Focus playlist
    tmux select-pane -t "$playlist"

    tmux set-hook -t "$SESSION" client-attached "set-option -t '$SESSION' destroy-unattached on"
    tmux attach-session -t "$SESSION"
  '';
}
