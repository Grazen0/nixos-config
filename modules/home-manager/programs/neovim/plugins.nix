{pkgs, ...}: {
  programs.neovim.plugins = let
    luaPlugin = plugin: config: {
      inherit plugin config;
      type = "lua";
    };

    luaPluginWithSetup = plugin: name: (luaPlugin plugin "require('${name}').setup({})");

    luaConfigPlugin = plugin: file: (luaPlugin plugin (builtins.readFile ./lua/plugins/${file}.lua));
  in
    with pkgs.vimPlugins; [
      (luaConfigPlugin kanagawa-nvim "kanagawa")
      (luaConfigPlugin neo-tree-nvim "neo-tree")
      (luaConfigPlugin lualine-nvim "lualine")
      (luaConfigPlugin bufferline-nvim "bufferline")
      (luaConfigPlugin mini-starter "mini-starter")
      (luaConfigPlugin mini-sessions "mini-sessions")

      (luaPluginWithSetup nvim-surround "nvim-surround")
      (luaPluginWithSetup nvim-autopairs "nvim-autopairs")
      (luaConfigPlugin multicursor-nvim "multicursor")
      (luaPluginWithSetup comment-nvim "Comment")
      (luaPlugin indent-blankline-nvim "require('ibl').setup({ indent = { char = '│' } })")
      (luaPluginWithSetup nvim-colorizer-lua "colorizer")
      vim-illuminate
      (luaPluginWithSetup fidget-nvim "fidget")
      (luaPluginWithSetup highlight-undo-nvim "highlight-undo")

      (luaConfigPlugin telescope-nvim "telescope")
      (luaConfigPlugin nvim-spectre "spectre")
      (luaConfigPlugin conform-nvim "conform")
      (luaConfigPlugin inc-rename-nvim "inc-rename")
      (luaPlugin lsp_signature-nvim "require('lsp_signature').setup({ handler_opts = { border = 'none' } })")
      (luaConfigPlugin nvim-navbuddy "navbuddy")
      vim-fugitive
      (luaConfigPlugin gitsigns-nvim "gitsigns")

      nvim-lspconfig
      SchemaStore-nvim

      (luaConfigPlugin nvim-cmp "cmp")
      cmp-nvim-lsp
      cmp-buffer
      cmp-async-path
      cmp-cmdline
      cmp-nvim-ultisnips

      lspkind-nvim

      neodev-nvim
      (luaConfigPlugin ultisnips "ultisnips")
      (luaConfigPlugin vimtex "vimtex")

      (luaConfigPlugin nvim-treesitter.withAllGrammars "treesitter/init")
      (luaConfigPlugin nvim-treesitter-refactor "treesitter/refactor")
      (luaConfigPlugin nvim-treesitter-textobjects "treesitter/textobjects")

      (luaPluginWithSetup nvim-window-picker "window-picker")
      (luaPluginWithSetup crates-nvim "crates")

      hmts-nvim
      nvim-web-devicons

      (luaConfigPlugin todo-comments-nvim "todo-comments")
      (luaPluginWithSetup markview-nvim "markview")
      (luaPlugin markdown-preview-nvim "vim.g.mkdp_filetypes = { 'markdown' }")
      (luaPluginWithSetup tailwindcss-colors-nvim "tailwindcss-colors")
      (luaPluginWithSetup hex-nvim "hex")
      (luaPluginWithSetup hmts-nvim "hmts")
      neocord
      cellular-automaton-nvim # Very important
    ];
}
