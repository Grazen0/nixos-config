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

    haskell-tools-nvim = vimPlugins.haskell-tools-nvim.overrideAttrs (prev: {
      patches = [./patches/haskell-tools.patch] ++ (prev.patches or []);
    });
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
      bullets-vim
      vim-tmux-navigator

      # LSP
      conform-nvim
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
      nvim-jdtls
      nvim-navbuddy

      # Visual
      kanagawa-nvim
      nvim-web-devicons
      nvim-colorizer-lua
      gitsigns-nvim
      lualine-nvim
      bufferline-nvim
      markview-nvim
      nvim-window-picker
      vim-illuminate
      tiny-inline-diagnostic-nvim

      # Misc
      vim-obsession
      todo-comments-nvim
      vimtex
      live-share-nvim
      crates-nvim
      markdown-preview-nvim
      lazydev-nvim
      which-key-nvim
      obsidian-nvim
      obsidian-bridge-nvim
      fidget-nvim
      nvim-dap
      nvim-dap-ui
      nvim-dap-virtual-text
      nvim-dap-python
      overseer-nvim
      rustaceanvim
      cmake-tools-nvim
      tailwind-tools-nvim
      haskell-tools-nvim
      mkdir-nvim
      snacks-nvim
    ];
}
