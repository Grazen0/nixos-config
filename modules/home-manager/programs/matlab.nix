{pkgs, ...}: {
  home.packages = with pkgs; [matlab];

  xdg.configFile."matlab/nix.sh".text = ''
    INSTALL_DIR="$HOME/.local/MATLAB"
  '';
}
