{ pkgs, ... }:
{
  programs.neovim = {
    extraPackages = with pkgs; [
      # Essentials
      fd
      ripgrep
      wl-clipboard

      # Conform formatters
      beautysh
      black
      clang-tools
      isort
      nixfmt-rfc-style
      ormolu
      prettierd
      rustfmt
      sql-formatter
      stylua
      typstyle

      # LSP servers
      autotools-language-server # Makefile
      bash-language-server
      clang-tools
      clippy
      cmake-language-server
      coursier
      gopls # Go
      jdt-language-server # Java
      lua-language-server
      metals
      nil # Nix
      pyright # Python
      rust-analyzer
      svelte-language-server
      tailwindcss-language-server
      texlab # LaTeX
      tinymist
      vscode-langservers-extracted # HTML, CSS, JSON
      vtsls
      yaml-language-server

      # Plugin-specifics
      texlive.combined.scheme-small # vimtex
      cmake # cmake-tools.nvim
      marp-cli # marp.nvim
      xxd # hex.nvim
    ];
  };
}
