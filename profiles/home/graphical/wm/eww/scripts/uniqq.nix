{ writeShellApplication, ... }:
writeShellApplication {
  name = "uniqq";
  text = ''
    "$@" | {
        prev=""
        while read -r line; do
            if [[ "$line" != "$prev" ]]; then
                echo "$line"
                prev="$line"
            fi
        done
    }
  '';
}
