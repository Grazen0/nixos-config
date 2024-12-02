{pkgs, ...}:
pkgs.writeShellApplication {
  name = "make-writable";
  text = ''
    if [[ "$#" -lt 1 ]]; then
      echo "No filename provided"
      exit 1
    fi

    contents=$(cat "$1")
    rm -f "$1"
    cat > "$1" <<< "$contents"
  '';
}
