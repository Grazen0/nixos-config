{
  config,
  pkgs,
  ...
}: let
  inherit (pkgs) vscode-extensions;
in
  # lua
  ''
    local M = {}

    M.lazy_dev_path = '${pkgs.vimUtils.packDir config.programs.neovim.finalPackage.passthru.packpathDirs}/pack/myNeovimPackages/start'

    M.codelldb_path = '${vscode-extensions.vadimcn.vscode-lldb}/share/vscode/extensions/vadimcn.vscode-lldb/adapter/codelldb'

    M.java_debug_path = '${vscode-extensions.vscjava.vscode-java-debug}/share/vscode/extensions/vscjava.vscode-java-debug/server/com.microsoft.java.debug.plugin-*.jar'

    return M
  ''
