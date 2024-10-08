{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.bash = {
    enable = true;
    historyControl = ["erasedups"];
    shellAliases = lib.removeAttrs config.programs.zsh.shellAliases ["/"];
    initExtra = ''
      source ${pkgs.aphrodite-terminal-theme}/share/bash/themes/aphrodite.theme.sh
    '';
  };
}
