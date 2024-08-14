{pkgs, ...}: {
  programs.nixvim = {
    extraPlugins = [pkgs.vimPlugins.ultisnips];

    globals = {
      UltiSnipsSnippetDirectories = [../ultisnips];
      UltiSnipsExpandTrigger = "<Plug>(ultisnips_expand)";
      UltiSnipsJumpForwardTrigger = "<Plug>(ultisnips_jump_forward)";
      UltiSnipsJumpBackwardTrigger = "<Plug>(ultisnips_jump_backward)";
      UltiSnipsListSnippets = "<C-x><C-s>";
      UltiSnipsRemoveSelectModeMappings = 0;
    };
  };
}
