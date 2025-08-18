{ config, pkgs, ... }:
# lua
''
  local M = {}

  M.lazy_dev_path = '${pkgs.vimUtils.packDir config.programs.neovim.finalPackage.passthru.packpathDirs}/pack/myNeovimPackages/start'
  M.java_debug_path = '${pkgs.vscode-extensions.vscjava.vscode-java-debug}/share/vscode/extensions/vscjava.vscode-java-debug/server/com.microsoft.java.debug.plugin-*.jar'
  M.lombok_path = '${pkgs.lombok}/share/java/lombok.jar'
  M.browser = '${config.meta.mainPrograms.browser}'

  return M
''
