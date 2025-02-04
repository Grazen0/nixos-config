{pkgs, ...}:
pkgs.writeShellApplication {
  name = "wlr-randr-all";
  runtimeInputs = with pkgs; [wlr-randr jq];
  text = ''
    outputs=$(wlr-randr --json | jq --raw-output '.[].name')
    echo "$outputs"

    for output in $outputs; do
        wlr-randr --output "$output" "$@"
    done
  '';
}
