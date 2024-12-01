{pkgs, ...}: {
  programs.neovim.plugins = let
    stablePlugins = pkgs.stable.vimPlugins;
  in
    with pkgs.vimPlugins; [
      # Editor
      nvim-cmp
      cmp-nvim-lsp
      cmp-buffer
      cmp-async-path
      cmp-cmdline
      cmp-nvim-ultisnips
      multicursor-nvim
      neo-tree-nvim
      nvim-spectre
      telescope-nvim
      ultisnips
      nvim-surround
      nvim-autopairs
      comment-nvim
      undotree
      lazygit-nvim

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

      # Visual
      kanagawa-nvim
      nvim-web-devicons
      nvim-colorizer-lua
      gitsigns-nvim
      lualine-nvim
      bufferline-nvim
      highlight-undo-nvim
      nvim-window-picker
      tailwindcss-colors-nvim
      hmts-nvim
      indent-blankline-nvim
      vim-illuminate
      dressing-nvim

      # Misc
      mini-sessions
      mini-starter
      todo-comments-nvim
      vimtex
      instant-nvim
      live-share-nvim
      crates-nvim
      hex-nvim
      neocord
      fidget-nvim
      markdown-preview-nvim
      neodev-nvim
    ];
}
