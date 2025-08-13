{ pkgs, ... }:
{
  xdg.nixConfigFile.nvim.source = ./config;

  programs.neovim = {
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    plugins = with pkgs.vimPlugins; [
      lazy-nvim

      # Mini
      mini-ai
      mini-extra
      mini-hipatterns
      mini-icons
      mini-pairs
      mini-sessions

      # Editor
      blink-cmp
      guess-indent-nvim
      nvim-spectre
      nvim-surround
      oil-nvim
      snacks-nvim
      undotree
      vim-tmux-navigator

      # LSP
      SchemaStore-nvim
      conform-nvim
      nvim-jdtls
      nvim-lspconfig
      nvim-treesitter.withAllGrammars

      # Visual
      fidget-nvim
      gitsigns-nvim
      kanagawa-nvim
      lualine-nvim
      vim-illuminate

      # Misc
      markdown-preview-nvim
      nvim-dap
      nvim-dap-ui
      nvim-dbee
      todo-comments-nvim
      typst-preview-nvim
      vimtex
      which-key-nvim
    ];

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
      statix
      tailwindcss-language-server
      texlab # LaTeX
      tinymist
      typescript-language-server
      vscode-langservers-extracted # HTML, CSS, JSON
      yaml-language-server

      # Plugin-specifics
      texlive.combined.scheme-small # vimtex
    ];

  };
}
