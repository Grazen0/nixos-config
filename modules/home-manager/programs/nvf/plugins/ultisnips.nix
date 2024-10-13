{pkgs, ...}: {
  programs.nvf.settings.vim = {
    extraPlugins = {
      ultisnips.package = pkgs.vimPlugins.ultisnips;

      cmp-ultisnips = {
        package = pkgs.vimPlugins.cmp-nvim-ultisnips;
        setup = "require('cmp_nvim_ultisnips').setup({})";
      };
    };

    autocomplete.sources.ultisnips = "[UltiSnips]";

    globals = {
      UltiSnipsSnippetDirectories = [../snippets];
      UltiSnipsExpandTrigger = "<C-j>";
      UltiSnipsJumpForwardTrigger = "<C-b>";
      UltiSnipsJumpBackwardTrigger = "<C-z>";
    };
  };
}
