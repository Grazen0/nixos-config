{
  pkgs,
  inputs,
  ...
}: {
  programs.neovim.plugins = let
    inherit (pkgs.vimUtils) buildVimPlugin;
    inherit (pkgs) vimPlugins;

    multicursor-nvim = buildVimPlugin {
      pname = "multicursor.nvim";
      version = "main";
      src = inputs.nvim-plugin-multicursor;
    };

    live-share-nvim = buildVimPlugin {
      pname = "live-share.nvim";
      version = "main";
      src = inputs.nvim-plugin-live-share;
      dependencies = with vimPlugins; [instant-nvim];
    };

    r-nvim = buildVimPlugin {
      pname = "R.nvim";
      version = "main";
      src = inputs.nvim-plugin-r-nvim;
      dependencies = with vimPlugins; [nvim-treesitter];
    };

    obsidian-bridge-nvim = buildVimPlugin {
      pname = "obsidian-bridge.nvim";
      version = "main";
      src = inputs.nvim-plugin-obsidian-bridge;
      dependencies = with vimPlugins; [plenary-nvim obsidian-nvim];
    };

    luasnip-latex-snippets-nvim = buildVimPlugin {
      pname = "luasnip-latex-snippets.nvim";
      version = "main";
      src = inputs.nvim-plugin-luasnip-latex-snippets;
      dependencies = with vimPlugins; [luasnip];
    };
  in
    with vimPlugins; [
      lazy-nvim

      # Editor
      blink-cmp
      blink-compat
      multicursor-nvim
      neo-tree-nvim
      yazi-nvim
      fzf-lua
      nvim-spectre
      luasnip
      luasnip-latex-snippets-nvim
      nvim-surround
      nvim-autopairs
      comment-nvim
      undotree
      lazygit-nvim
      bullets-vim
      vim-tmux-navigator

      # LSP
      conform-nvim
      inc-rename-nvim
      nvim-navbuddy
      tiny-inline-diagnostic-nvim
      nvim-treesitter.withAllGrammars
      nvim-treesitter-refactor
      nvim-treesitter-textobjects
      nvim-treesitter-context
      nvim-ts-autotag
      trouble-nvim
      nvim-lspconfig
      SchemaStore-nvim
      vim-fugitive
      otter-nvim

      # Visual
      kanagawa-nvim
      nvim-web-devicons
      nvim-colorizer-lua
      gitsigns-nvim
      lualine-nvim
      bufferline-nvim
      markview-nvim
      nvim-window-picker
      tailwindcss-colors-nvim
      tiny-devicons-auto-colors-nvim
      indent-blankline-nvim
      vim-illuminate
      dressing-nvim

      # Misc
      dashboard-nvim
      vim-obsession
      todo-comments-nvim
      vimtex
      live-share-nvim
      crates-nvim
      markdown-preview-nvim
      lazydev-nvim
      r-nvim
      which-key-nvim
      obsidian-nvim
      obsidian-bridge-nvim
      molten-nvim
      quarto-nvim
      telescope-nvim
    ];
}
