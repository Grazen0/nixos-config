{ writeShellApplication, player-art, ... }:
writeShellApplication {
  name = "tmux-music";
  runtimeInputs = [ player-art ];
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

    # If anything goes wrong before attaching, kill the session
    trap 'tmux kill-session -t $SESSION' EXIT

    visualizer=$(tmux new-session -d -s "$SESSION" -x- -y- -P -F "#{pane_id}" "ncmpcpp -s visualizer -c '$XDG_CONFIG_HOME/ncmpcpp/visualizer.conf'")

    # Open panes
    playlist=$(tmux split-window -v -l "45%" -P -F "#{pane_id}" "ncmpcpp -s playlist -c '$XDG_CONFIG_HOME/ncmpcpp/minimal.conf'")
    tmux split-window -h -l "60%" "ncmpcpp -s browser -c '$XDG_CONFIG_HOME/ncmpcpp/minimal.conf'"
    tmux split-window -h -l "50%" "ncmpcpp -s search_engine -c '$XDG_CONFIG_HOME/ncmpcpp/minimal.conf'"
    tmux split-window -h -b -t "$visualizer" -l "30%" "player-art '$DEFAULT_IMG'"

    # Focus playlist
    tmux select-pane -t "$playlist"

    trap - EXIT
    tmux set-hook -t "$SESSION" client-attached "set -t '$SESSION' destroy-unattached on"
    tmux attach-session -t "$SESSION"
  '';
}
