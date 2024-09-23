{
  programs.nixvim.files = let
    indentSpace = w: {
      localOpts = {
        expandtab = true;
        shiftwidth = w;
        tabstop = w;
      };
    };

    filetypes = {
      nix = indentSpace 2;
      haskell = indentSpace 2;
      yuck = indentSpace 2;
      html = indentSpace 2;
      json = indentSpace 2;
      css = indentSpace 2;
      scss = indentSpace 2;
      javascript = indentSpace 2;
      typescript = indentSpace 2;
      typescriptreact = indentSpace 2;
      javascriptreact = indentSpace 2;

      tex = {
        localOpts = {
          conceallevel = 2;
          spell = true;
        };

        keymaps = [
          {
            mode = "n";
            key = "<C-f>";
            action = '': silent exec '!inkscape-figures edit "'.b:vimtex.root.'/figures/" > /dev/null 2>&1 &'<CR><CR>:redraw!<CR>'';
            options = {
              buffer = true;
              silent = true;
            };
          }
          {
            mode = "i";
            key = "<C-f>";
            action = ''<Esc>: silent exec '.!inkscape-figures create "'.getline('.').'" "'.b:vimtex.root.'/figures/"'<CR><CR>:w<CR>'';
            options = {
              buffer = true;
              silent = true;
            };
          }
        ];
      };
    };
  in
    builtins.listToAttrs (map (ft: {
      name = "ftplugin/${ft}.lua";
      value = filetypes.${ft};
    }) (builtins.attrNames filetypes));
}
