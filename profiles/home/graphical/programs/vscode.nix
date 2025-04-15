{
  config,
  pkgs,
  inputs,
  ...
}: let
  vscodeUtils = pkgs.callPackage "${inputs.nixpkgs}/pkgs/applications/editors/vscode/extensions/vscode-utils.nix" {};

  inherit (vscodeUtils) buildVscodeMarketplaceExtension;

  qufiwefefwoyn-kanagawa = buildVscodeMarketplaceExtension {
    mktplcRef = {
      publisher = "qufiwefefwoyn";
      name = "kanagawa";
      version = "1.5.1";
      hash = "sha256-AGGioXcK/fjPaFaWk2jqLxovUNR59gwpotcSpGNbj1c=";
    };
  };
in {
  programs.vscode = {
    enable = true;
    mutableExtensionsDir = true;

    profiles.default = {
      enableUpdateCheck = false;

      extensions = with pkgs.vscode-extensions; [
        qufiwefefwoyn-kanagawa
        pkief.material-icon-theme
        vscodevim.vim
        svelte.svelte-vscode
        bradlc.vscode-tailwindcss
        editorconfig.editorconfig
        esbenp.prettier-vscode
        ms-vscode.hexeditor
        jnoortheen.nix-ide
        llvm-vs-code-extensions.vscode-clangd
        shd101wyy.markdown-preview-enhanced
        ms-vscode.cmake-tools
        ms-vscode.makefile-tools
      ];

      userSettings = {
        "keyboard.dispatch" = "keyCode";
        "explorer.confirmDelete" = false;
        "editor.formatOnSave" = true;
        "workbench.colorTheme" = "Kanagawa";
        "vim.highlightedyank.enable" = true;
        "vim.leader" = " ";
        "workbench.iconTheme" = "material-icon-theme";
        "clangd.path" = "${pkgs.clang-tools}/bin/clangd";
        "editor.fontFamily" = "'${config.theme.font.regular}', 'monospace', monospace";
        "nix.formatterPath" = "${pkgs.nixfmt-classic}/bin/nixfmt";
        "nix.serverPath" = "${pkgs.nil}/bin/nil";
        "cmake.cmakePath" = "${pkgs.cmake}/bin/cmake";
        "cmake.configureOnOpen" = true;
        "markdown-preview-enhanced.previewTheme" = "github-dark.css";
        "editor.lineNumbers" = "relative";
      };
    };
  };
}
