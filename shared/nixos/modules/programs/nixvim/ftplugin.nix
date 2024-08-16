{
  programs.nixvim.files = let
    indentSpace = w: {
      opts = {
        expandtab = true;
        shiftwidth = w;
        tabstop = w;
      };
    };
  in {
    "ftplugin/nix.lua" = indentSpace 2;
    "ftplugin/haskell.lua" = indentSpace 2;

    "ftplugin/tex.lua" = {
      opts = {
        conceallevel = 1;
        spell = true;
      };
    };
  };
}
