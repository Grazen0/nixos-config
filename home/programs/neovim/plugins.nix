{
  pkgs,
  stablePkgs,
  inputs,
  ...
}: {
  programs.neovim.plugins = let
    inherit (pkgs.vimUtils) buildVimPlugin;
    inherit (pkgs) vimPlugins;
    stablePlugins = stablePkgs.vimPlugins;

    multicursor-nvim = buildVimPlugin {
      name = "multicursor-nvim";
      src = inputs.nvim-plugin-multicursor;
    };

    live-share-nvim = buildVimPlugin {
      name = "live-share-nvim";
      src = inputs.nvim-plugin-live-share;
      dependencies = with vimPlugins; [instant-nvim];
    };

    r-nvim = buildVimPlugin {
      name = "r-nvim";
      src = inputs.nvim-plugin-r-nvim;
      dependencies = with vimPlugins; [nvim-treesitter];
    };

    cmp-r = buildVimPlugin {
      name = "cmp-r";
      src = inputs.nvim-plugin-cmp-r;
      dependencies = with vimPlugins; [nvim-cmp];
    };
  in
    with vimPlugins; [
      # Editor
      nvim-cmp
      cmp-nvim-lsp
      cmp-buffer
      cmp-async-path
      cmp-cmdline
      cmp-nvim-ultisnips
      cmp-r
      multicursor-nvim
      neo-tree-nvim
      fzf-lua
      nvim-spectre
      ultisnips
      nvim-surround
      nvim-autopairs
      comment-nvim
      undotree
      lazygit-nvim
      bullets-vim

      # LSP
      conform-nvim
      stablePlugins.inc-rename-nvim
      nvim-navbuddy
      tiny-inline-diagnostic-nvim
      nvim-treesitter.withAllGrammars
      nvim-treesitter-refactor
      nvim-treesitter-textobjects
      nvim-treesitter-context
      nvim-ts-autotag
      trouble-nvim
      lsp_signature-nvim
      nvim-lspconfig
      SchemaStore-nvim
      lspkind-nvim
      vim-fugitive
      otter-nvim

      # Visual
      kanagawa-nvim
      nvim-web-devicons
      nvim-colorizer-lua
      gitsigns-nvim
      lualine-nvim
      bufferline-nvim
      highlight-undo-nvim
      markview-nvim
      nvim-window-picker
      tailwindcss-colors-nvim
      tiny-devicons-auto-colors-nvim
      hmts-nvim
      indent-blankline-nvim
      vim-illuminate
      dressing-nvim

      # Misc
      mini-sessions
      mini-starter
      todo-comments-nvim
      vimtex
      live-share-nvim
      crates-nvim
      hex-nvim
      presence-nvim
      fidget-nvim
      markdown-preview-nvim
      lazydev-nvim
      image-nvim
      r-nvim
      which-key-nvim
      obsidian-nvim
    ];
}
