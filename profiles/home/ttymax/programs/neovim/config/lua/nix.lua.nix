{ config, pkgs, ... }:
let
  inherit (pkgs) vscode-extensions;

  lombok = pkgs.fetchurl {
    url = "https://projectlombok.org/downloads/lombok-1.18.38.jar";
    hash = "sha256-Hh5CfDb/Y8RP0w7yktnnc+oxVEYKtiZdP+1+b1vFD7k=";
  };

  junit = pkgs.fetchurl {
    url = "https://repo1.maven.org/maven2/org/junit/platform/junit-platform-console-standalone/1.10.1/junit-platform-console-standalone-1.10.1.jar";
    hash = "sha256-tC6qU9E1dtF9tfuLKAcipq6eNtr5X0JivG6W1Msgcl8=";
  };
in
# lua
''
  local M = {}

  M.lazy_dev_path = '${pkgs.vimUtils.packDir config.programs.neovim.finalPackage.passthru.packpathDirs}/pack/myNeovimPackages/start'

  M.codelldb_path = '${vscode-extensions.vadimcn.vscode-lldb}/share/vscode/extensions/vadimcn.vscode-lldb/adapter/codelldb'

  M.java_debug_path = '${vscode-extensions.vscjava.vscode-java-debug}/share/vscode/extensions/vscjava.vscode-java-debug/server/com.microsoft.java.debug.plugin-*.jar'

  M.lombok_path = '${lombok}'

  M.junit_path = '${junit}'

  return M
''
