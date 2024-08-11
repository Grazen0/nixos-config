{
  programs.nixvim.files = {
    "ftplugin/nix.lua" = {
      opts = {
        expandtab = true;
        shiftwidth = 2;
        tabstop = 2;
      };
    };

    "ftplugin/tex.lua" = {
      opts = {
        conceallevel = 1;
        spell = true;
      };
    };
  };
}
