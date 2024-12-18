{
  pkgs,
  stablePkgs,
  inputs,
  ...
}: {
  programs.neovim.plugins = let
    inherit (pkgs.vimUtils) buildVimPlugin;
    stablePlugins = stablePkgs.vimPlugins;

    multicursor-nvim = buildVimPlugin {
      name = "multicursor-nvim";
      src = inputs.nvim-plugin-multicursor;
    };

    live-share-nvim = buildVimPlugin {
      name = "live-share-nvim";
      src = inputs.nvim-plugin-live-share;
      dependencies = with pkgs.vimPlugins; [instant-nvim];
    };

    tiny-code-action-nvim = buildVimPlugin {
      name = "tiny-code-action-nvim";
      src = inputs.nvim-plugin-tiny-code-action;
    };
  in
    with pkgs.vimPlugins; [
      # Editor
      blink-cmp
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
      tiny-code-action-nvim
      nvim-treesitter.withAllGrammars
      nvim-treesitter-refactor
      nvim-treesitter-textobjects
      nvim-treesitter-context
      nvim-ts-autotag
      trouble-nvim
      lsp_signature-nvim
      nvim-lspconfig
      SchemaStore-nvim
      vim-fugitive

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
    ];
}
