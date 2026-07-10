{ config, pkgs, ... }:
# lua
''
  local M = {}

  M.lombok_path = '${pkgs.lombok}/share/java/lombok.jar'
  M.browser = '${config.meta.mainPrograms.browser}'
  M.tsdk = '${pkgs.typescript}/lib/node_modules/typescript/lib'

  return M
''
