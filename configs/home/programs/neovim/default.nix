{
  pkgs,
  inputs,
  ...
}:
{
  xdg.nixConfigFile.nvim.source = ./config;

  programs.neovim = {
    package = inputs.neovim-nightly-overlay.packages.${pkgs.stdenv.hostPlatform.system}.default;

    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    plugins = with pkgs.vimPlugins; [
      lazy-nvim
    ];

    extraPackages = with pkgs; [
      # Essentials
      fd
      ripgrep
      wl-clipboard
      tree-sitter

      # Conform formatters
      nixfmt
      ormolu
      prettierd
      black
      isort
      rustfmt
      typstyle

      # LSP servers
      arduino-language-server
      pyright # Python
      bash-language-server
      clang-tools
      clang
      stdenv.cc.libc.dev
      llvmPackages.libcxx
      clippy
      cmake-language-server
      coursier
      gopls # Go
      jdt-language-server # Java
      # kotlin-language-server
      lua-language-server
      metals
      nil # Nix
      rust-analyzer
      sqls
      statix
      svelte-language-server
      tailwindcss-language-server
      terraform-lsp
      texlab # LaTeX
      tinymist
      typescript-language-server
      verible
      verilator
      vscode-langservers-extracted # HTML, CSS, JSON
      yaml-language-server
      zls

      # Plugin-specifics
      texlive.combined.scheme-small # vimtex
    ];

  };
}
