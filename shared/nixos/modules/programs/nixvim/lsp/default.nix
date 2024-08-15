{
  imports = [
    ./treesitter.nix
  ];

  programs.nixvim = {
    plugins = {
      lsp = {
        enable = true;

        servers = {
          nil-ls.enable = true;
          lua-ls.enable = true;

          tsserver.enable = true;
          html.enable = true;
          emmet-ls.enable = true;
          cssls.enable = true;
          jsonls.enable = true;
          yamlls.enable = true;
          tailwindcss.enable = true;
          svelte.enable = true;

          pyright.enable = true;

          clangd.enable = true;
          cmake.enable = true;

          # Rust
          rust-analyzer = {
            enable = true;
            installRustc = true;
            installCargo = true;
          };

          texlab.enable = true;

          hls.enable = true; # Haskell
        };
      };

      lspkind.enable = true;
      # hmts.enable = true; # Causes crash on peaclock.nix
      schemastore.enable = true;
    };

    diagnostics.virtual_text = false;

    extraConfigLua = ''
      -- Custom icons
      local signs = {
      	Error = '󰅙 ',
      	Warn = ' ',
      	Hint = '󰌵 ',
      	Info = ' ',
      };

      for type, icon in pairs(signs) do
      	local hl = 'DiagnosticSign' .. type;
      	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl });
      end
    '';
  };
}
