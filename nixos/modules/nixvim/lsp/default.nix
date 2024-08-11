{pkgs, ...}: {
  imports = [
    ./treesitter.nix
  ];

  programs.nixvim = {
    extraPlugins = [pkgs.vimPlugins.SchemaStore-nvim];

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
          jsonls = {
            enable = true;
            settings = {
              schemas.__raw = "require('schemastore').json.schemas()";
              validate.enable = true;
            };
          };
          yamlls = {
            enable = true;
            settings = {
              schemaStore = {
                enable = false;
                url = "";
              };

              schemas.__raw = "require('schemastore').yaml.schemas()";
            };
          };
          tailwindcss.enable = true;
          svelte.enable = true;

          pyright.enable = true;

          clangd.enable = true;
          cmake.enable = true;

          rust-analyzer = {
            enable = true;
            installRustc = true;
            installCargo = true;
          };

          texlab.enable = true;
        };
      };

      lspkind.enable = true;
      # hmts.enable = true; # Causes crash on peaclock.nix
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
