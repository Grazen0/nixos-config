{pkgs, ...}:
pkgs.writeShellApplication {
  name = "exe2png";
  runtimeInputs = with pkgs; [icoutils imagemagick];
  text = ''
    if [[ "$#" -lt 1 ]]; then
      echo "No source file provided"
      exit 1
    fi

    src=$1
    dest=''${2:-''${src%.*}.png}

    wrestool -x -t 14 "$src" | magick ico:- "$dest"
  '';
}
