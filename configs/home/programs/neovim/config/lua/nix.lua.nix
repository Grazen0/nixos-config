{ config, pkgs, ... }:
# lua
''
  local M = {}

  M.lombok_path = '${pkgs.lombok}/share/java/lombok.jar'
  M.browser = '${config.meta.mainPrograms.browser}'

  return M
''
