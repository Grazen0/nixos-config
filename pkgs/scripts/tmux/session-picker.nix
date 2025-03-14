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
    set -x
    sessions=$(tmux list-sessions -F '#S')
    sessions_len=$(echo "$sessions" | wc -l)

    tmux_opts="center,24,$((sessions_len + 3))"
    fzf_flags=(
        --tmux="$tmux_opts"
        --border=sharp
        --border-label=" Sessions "
        --no-separator
        --no-info
        --color="prompt:bright-black,query:bright-black,border:white"
        --layout=reverse
        --exact
        --no-ignore-case
        --query="^"
    )

    if selection=$(echo "$sessions" | fzf "''${fzf_flags[@]}"); then
        tmux switch-client -t "$selection"
    fi
  '';
}
