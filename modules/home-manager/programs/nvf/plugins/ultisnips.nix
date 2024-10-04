{pkgs, ...}: {
  programs.nvf.settings.vim = {
    extraPlugins = {
      ultisnips.package = pkgs.vimPlugins.ultisnips;

      cmp-ultisnips = {
        package = pkgs.vimPlugins.cmp-nvim-ultisnips;
        setup = "require('cmp_nvim_ultisnips').setup({})";
      };
    };

    globals = {
      UltiSnipsSnippetDirectories = [../snippets];
      UltiSnipsExpandTrigger = "<Nop>";
      UltiSnipsJumpForwardTrigger = "<C-b>";
      UltiSnipsJumpBackwardTrigger = "<C-z>";
    };
  };
}
