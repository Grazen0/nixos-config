{ pkgs, inputs, ... }:
{
  programs.neovim.plugins =
    let
      inherit (pkgs.vimUtils) buildVimPlugin;
      inherit (pkgs) vimPlugins;

      nvim-spectre = vimPlugins.nvim-spectre.overrideAttrs { doCheck = false; };

      multicursor-nvim = buildVimPlugin {
        pname = "multicursor.nvim";
        version = "main";
        src = inputs.nvim-plugin-multicursor;
      };

      live-share-nvim = buildVimPlugin {
        pname = "live-share.nvim";
        version = "main";
        src = inputs.nvim-plugin-live-share;
        dependencies = with vimPlugins; [ instant-nvim ];
      };

      obsidian-nvim = buildVimPlugin {
        pname = "obsidian.nvim";
        version = "main";
        src = inputs.nvim-plugin-obsidian;
        dependencies = with vimPlugins; [ plenary-nvim ];
        patches = [ ./patches/obsidian-nvim.patch ];
        doCheck = false;
      };

      obsidian-bridge-nvim = buildVimPlugin {
        pname = "obsidian-bridge.nvim";
        version = "main";
        src = inputs.nvim-plugin-obsidian-bridge;
        dependencies = with vimPlugins; [
          plenary-nvim
          obsidian-nvim
        ];
      };

      luasnip-latex-snippets-nvim = buildVimPlugin {
        pname = "luasnip-latex-snippets.nvim";
        version = "main";
        src = inputs.nvim-plugin-luasnip-latex-snippets;
        dependencies = with vimPlugins; [ luasnip ];
      };

      marp-nvim = buildVimPlugin {
        pname = "marp-nvim";
        version = "main";
        src = inputs.nvim-plugin-marp;
      };
    in
    with vimPlugins;
    [
      lazy-nvim

      # Editor
      blink-cmp
      multicursor-nvim
      yazi-nvim
      nvim-spectre
      luasnip
      luasnip-latex-snippets-nvim
      nvim-surround
      nvim-autopairs
      comment-nvim
      undotree
      bullets-vim
      vim-tmux-navigator
      nvim-ufo

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
      nvim-jdtls
      # nvim-navbuddy

      # Visual
      kanagawa-nvim
      nvim-web-devicons
      nvim-colorizer-lua
      lualine-nvim
      bufferline-nvim
      markview-nvim
      nvim-window-picker
      vim-illuminate
      tiny-inline-diagnostic-nvim
      gitsigns-nvim

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
      # fidget-nvim
      nvim-dap
      nvim-dap-ui
      nvim-dap-virtual-text
      nvim-dap-python
      overseer-nvim
      rustaceanvim
      cmake-tools-nvim
      tailwind-tools-nvim
      # customPkgs.vim-plugin-haskell-tools-nvim
      snacks-nvim
      nvim-dbee
      marp-nvim
      hex-nvim
    ];
}
