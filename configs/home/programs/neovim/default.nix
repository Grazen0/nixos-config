{ pkgs, inputs, ... }:
{
  xdg.nixConfigFile.nvim.source = ./config;

  programs.neovim = {
    package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;

    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    plugins = with pkgs.vimPlugins; [
      lazy-nvim

      # Mini
      mini-ai
      mini-extra
      mini-icons
      mini-pairs
      mini-sessions

      # Editor
      blink-cmp
      guess-indent-nvim
      luasnip
      nvim-spectre
      nvim-surround
      oil-nvim
      snacks-nvim
      undotree
      vim-tmux-navigator

      # LSP
      conform-nvim
      nvim-jdtls
      nvim-lspconfig
      nvim-treesitter.withAllGrammars
      SchemaStore-nvim

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
      kotlin-language-server
      lua-language-server
      metals
      nil # Nix
      pyright # Python
      rust-analyzer
      statix
      svelte-language-server
      svls
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
