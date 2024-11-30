{
  lib,
  pkgs,
  ...
}: {
  programs.neovim.plugins = let
    withLuaConfig = plugin: config: {
      inherit plugin config;
      type = "lua";
    };

    withSetup = plugin: name: (withLuaConfig plugin "require('${name}').setup({})");

    withFile = plugin: file: (withLuaConfig plugin (lib.readFile ./lua/plugins/${file}.lua));
  in
    with pkgs.vimPlugins; [
      (withFile kanagawa-nvim "kanagawa")
      (withFile neo-tree-nvim "neo-tree")
      (withFile lualine-nvim "lualine")
      (withFile bufferline-nvim "bufferline")
      (withFile mini-starter "mini-starter")
      (withFile mini-sessions "mini-sessions")
      (withLuaConfig instant-nvim "vim.g.instant_username = 'Grazen'")
      (withSetup live-share-nvim "live-share")

      (withSetup nvim-surround "nvim-surround")
      (withSetup nvim-autopairs "nvim-autopairs")
      (withFile multicursor-nvim "multicursor")
      (withSetup comment-nvim "Comment")
      (withLuaConfig indent-blankline-nvim "require('ibl').setup({ indent = { char = '│' } })")
      (withFile nvim-colorizer-lua "colorizer")
      vim-illuminate
      (withLuaConfig fidget-nvim "require('fidget').setup({ notification = { window = { winblend = 0 } } })")
      (withSetup highlight-undo-nvim "highlight-undo")
      (withLuaConfig undotree "vim.keymap.set('n', '<leader>u', '<cmd>UndotreeShow<CR>')")

      (withFile telescope-nvim "telescope")
      (withFile nvim-spectre "spectre")
      (withFile trouble-nvim "trouble")
      (withFile conform-nvim "conform")
      (withFile inc-rename-nvim "inc-rename")
      (withLuaConfig lsp_signature-nvim "require('lsp_signature').setup({ handler_opts = { border = 'none' } })")
      (withFile nvim-navbuddy "navbuddy")
      vim-fugitive
      (withFile gitsigns-nvim "gitsigns")
      (withLuaConfig lazygit-nvim "vim.keymap.set('n', '<leader>lg', '<cmd>LazyGit<CR>')")
      (withFile tiny-inline-diagnostic-nvim "tiny-inline-diagnostic")

      nvim-lspconfig
      SchemaStore-nvim

      (withFile nvim-cmp "cmp")
      cmp-nvim-lsp
      cmp-buffer
      cmp-async-path
      cmp-cmdline
      cmp-nvim-ultisnips

      lspkind-nvim

      neodev-nvim
      (withLuaConfig ultisnips ''
        vim.g.UltiSnipsSnippetDirectories = { '${./snippets}' }
        ${lib.readFile ./lua/plugins/ultisnips.lua}
      '')
      (withFile vimtex "vimtex")

      (withFile nvim-treesitter.withAllGrammars "treesitter/init")
      (withFile nvim-treesitter-refactor "treesitter/refactor")
      (withFile nvim-treesitter-textobjects "treesitter/textobjects")
      (withSetup nvim-ts-autotag "nvim-ts-autotag")
      (withSetup nvim-treesitter-context "treesitter-context")

      (withSetup nvim-window-picker "window-picker")
      (withSetup crates-nvim "crates")

      hmts-nvim
      nvim-web-devicons

      (withFile todo-comments-nvim "todo-comments")
      (withLuaConfig markdown-preview-nvim "vim.g.mkdp_filetypes = { 'markdown' }")
      (withSetup tailwindcss-colors-nvim "tailwindcss-colors")
      (withSetup hex-nvim "hex")
      (withSetup hmts-nvim "hmts")
      (withSetup neocord "neocord")
    ];
}
