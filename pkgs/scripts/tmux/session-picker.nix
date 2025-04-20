{
  writeShellApplication,
  tmux,
  ppick,
  ...
}:
writeShellApplication {
  name = "tmux-session-picker";
  runtimeInputs = [ tmux ];
  text =
    let
      ppick_bin = "${ppick}/bin/ppick";
    in
    # bash
    ''
      sessions=$(tmux list-sessions -F '#S')
      sessions_len=$(echo "$sessions" | wc -l)

      # shellcheck disable=SC2016
      tmux display-popup -E -T " Sessions " -h $((sessions_len + 2)) -w 24 \
        'tmux switch-client -t $(tmux list-sessions -F "#S" | ${ppick_bin}) || true'
    '';
}
