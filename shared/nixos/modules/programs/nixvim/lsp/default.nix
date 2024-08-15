{
  imports = [
    ./treesitter.nix
  ];

  programs.nixvim = {
    plugins = {
      lsp = {
        enable = true;

        servers = {
          nil-ls.enable = true; # Nix
          lua-ls.enable = true; # Lua
          hls.enable = true; # Haskell
          pyright.enable = true; # Python

          tsserver.enable = true; # TypeScript/JavaScript
          html.enable = true; # HTML
          emmet-ls.enable = true; # HTML emmet snippets
          cssls.enable = true; # CSS
          jsonls.enable = true; # JSON
          yamlls.enable = true; # YAML
          tailwindcss.enable = true; # TailwindCSS
          svelte.enable = true; # Svelte

          clangd.enable = true; # C/C++
          cmake.enable = true; # GNU Make

          # Rust
          rust-analyzer = {
            enable = true;
            installRustc = true;
            installCargo = true;
          };

          texlab.enable = true; # LaTeX
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
