{ pkgs, ... }:
{
  xdg.nixConfigFile.nvim.source = ./config;

  programs.neovim = {
    enable = true;

    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    extraPackages = with pkgs; [
      # Essentials
      fd
      ripgrep
      wl-clipboard

      # Conform formatters
      black
      isort
      nixfmt-rfc-style
      ormolu
      prettierd
      sql-formatter
      typstyle

      # LSP servers
      bash-language-server
      clang-tools
      clippy
      cmake-language-server
      coursier
      emmet-language-server
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
      typescript-language-server
      vscode-langservers-extracted # HTML, CSS, JSON
      yaml-language-server

      # Plugin-specifics
      texlive.combined.scheme-small # vimtex
    ];

    plugins = with pkgs.vimPlugins; [
      lazy-nvim

      # Mini
      mini-ai
      mini-pairs
      mini-hipatterns
      mini-sessions
      mini-extra

      # Editor
      blink-cmp
      oil-nvim
      nvim-spectre
      nvim-surround
      undotree
      vim-tmux-navigator
      guess-indent-nvim

      # LSP
      conform-nvim
      nvim-treesitter.withAllGrammars
      nvim-lspconfig
      SchemaStore-nvim
      nvim-jdtls

      # Visual
      kanagawa-nvim
      nvim-web-devicons
      lualine-nvim
      vim-illuminate
      gitsigns-nvim
      fidget-nvim

      # Misc
      todo-comments-nvim
      vimtex
      markdown-preview-nvim
      which-key-nvim
      nvim-dap
      nvim-dap-ui
      snacks-nvim
      nvim-dbee
      typst-preview-nvim
    ];
  };
}
