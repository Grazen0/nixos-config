{ pkgs, inputs, ... }:
{
  programs.neovim.plugins =
    let
      inherit (pkgs.vimUtils) buildVimPlugin;
      inherit (pkgs) vimPlugins;

      nvim-spectre = vimPlugins.nvim-spectre.overrideAttrs { doCheck = false; };

      neotest-java = vimPlugins.neotest-java.overrideAttrs {
        patches = [ ./patches/neotest-java.patch ];
      };

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

      luasnip-latex-snippets-nvim = buildVimPlugin {
        pname = "luasnip-latex-snippets.nvim";
        version = "main";
        src = inputs.nvim-plugin-luasnip-latex-snippets;
        dependencies = with vimPlugins; [ luasnip ];
      };

    in
    with vimPlugins;
    [
      lazy-nvim

      # Editor
      blink-cmp
      multicursor-nvim
      # yazi-nvim
      oil-nvim
      nvim-spectre
      luasnip
      luasnip-latex-snippets-nvim
      nvim-surround
      nvim-autopairs
      undotree
      bullets-vim
      vim-tmux-navigator

      # LSP
      conform-nvim
      nvim-treesitter.withAllGrammars
      nvim-treesitter-textobjects
      nvim-treesitter-context
      nvim-ts-autotag
      nvim-lspconfig
      SchemaStore-nvim
      nvim-jdtls

      # Visual
      kanagawa-nvim
      nvim-web-devicons
      nvim-colorizer-lua
      lualine-nvim
      bufferline-nvim
      # markview-nvim
      vim-illuminate
      gitsigns-nvim

      # Misc
      vim-obsession
      todo-comments-nvim
      vimtex
      live-share-nvim
      crates-nvim
      markdown-preview-nvim
      which-key-nvim
      # obsidian-nvim
      # obsidian-bridge-nvim
      nvim-dap
      nvim-dap-ui
      # nvim-dap-virtual-text
      # overseer-nvim
      cmake-tools-nvim
      snacks-nvim
      nvim-dbee
      hex-nvim
      # neotest
      # neotest-rust
      # neotest-java
      FixCursorHold-nvim
      fidget-nvim
      nvim-metals
      typst-preview-nvim
    ];
}
