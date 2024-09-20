{
  programs.nixvim.plugins = {
    cmp = {
      enable = true;

      settings = {
        mapping.__raw = ''
          cmp.mapping.preset.insert({
            ["<C-Space>"] = cmp.mapping.complete(),
            ["<C-e>"] = cmp.mapping.close(),
            ["<C-d>"] = cmp.mapping.scroll_docs(-4),
            ["<C-f>"] = cmp.mapping.scroll_docs(4),
            ["<CR>"] = cmp.mapping.confirm({ select = true }),
            ["<Tab>"] = cmp.mapping(
              require("cmp_nvim_ultisnips.mappings")
                .compose({ "select_next_item", "jump_forwards" }),
              { "i", "s" }),
            ["<S-Tab>"] = cmp.mapping(
              require("cmp_nvim_ultisnips.mappings")
                .compose({ "select_prev_item", "jump_backwards" }),
              { "i", "s" }),
          })
        '';

        sources = [
          {name = "async_path";}
          {name = "nvim_lsp";}
          {name = "ultisnips";}
          {
            name = "buffer";
            option.get_bufnrs.__raw = "vim.api.nvim_list_bufs"; # Other buffers
          }
        ];
      };
    };

    cmp-cmdline.enable = true;
    cmp-nvim-ultisnips.enable = true;
  };

  programs.nixvim.extraConfigLua = ''
    local cmp = require('cmp');

    -- Search completion
    cmp.setup.cmdline({ '/', '?' }, {
        completion = { autocomplete = false },
        mapping = cmp.mapping.preset.cmdline(),
        sources = { { name = 'buffer' } },
        view = {
            entries = { name = 'wildmenu', separator = '|' },
        },
    })

    -- Command completion
    cmp.setup.cmdline(':', {
        completion = { autocomplete = false },
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources(
            { { name = 'async_path' } },
            { { name = 'cmdline' } }
        ),
        matching = { disallow_symbol_nonprefix_matching = false },
    })
  '';
}
