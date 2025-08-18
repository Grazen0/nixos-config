{ config, pkgs, ... }:
# lua
''
  local M = {}

  M.lazy_dev_path = '${pkgs.vimUtils.packDir config.programs.neovim.finalPackage.passthru.packpathDirs}/pack/myNeovimPackages/start'
  M.lombok_path = '${pkgs.lombok}/share/java/lombok.jar'
  M.browser = '${config.meta.mainPrograms.browser}'

  return M
''
