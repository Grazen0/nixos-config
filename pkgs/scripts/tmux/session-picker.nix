{
  writeShellApplication,
  tmux,
  fzf,
  ...
}:
writeShellApplication {
  name = "tmux-session-picker";
  runtimeInputs = [tmux fzf];
  text = ''
    sessions=$(tmux list-sessions -F '#S')
    sessions_len=$(echo "$sessions" | wc -l)

    tmux_flags="center,24,$((sessions_len + 3)),border-native"

    if selection=$(echo "$sessions" | fzf --tmux="$tmux_flags" --no-separator --info=hidden --layout=reverse); then
        tmux switch-client -t "$selection"
    fi
  '';
}
