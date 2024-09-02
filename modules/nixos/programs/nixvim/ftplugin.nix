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
          conceallevel = 1;
          spell = true;
        };
      };
    };
  in
    builtins.listToAttrs (map (ft: {
      name = "ftplugin/${ft}.lua";
      value = filetypes.${ft};
    }) (builtins.attrNames filetypes));
}
