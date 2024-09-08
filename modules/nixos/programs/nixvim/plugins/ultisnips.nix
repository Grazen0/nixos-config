{pkgs, ...}: {
  programs.nixvim = {
    extraPlugins = [pkgs.vimPlugins.ultisnips];

    globals = {
      UltiSnipsSnippetDirectories = [../ultisnips];
      UltiSnipsListSnippets = "<C-x><C-s>";
      UltiSnipsRemoveSelectModeMappings = 0;
    };
  };
}
