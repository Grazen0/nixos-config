{pkgs, ...}: {
  programs.nvf.settings.vim.extraPlugins = {
    mini-starter = {
      package = pkgs.vimPlugins.mini-starter;
      setup = ''
        require('mini.starter').setup({
          header = [[
                                    Welcome back to

             ██████   █████                                ███
            ░░██████ ░░███                                ░░░
             ░███░███ ░███   ██████   ██████  █████ █████ ████  █████████████
             ░███░░███░███  ███░░███ ███░░███░░███ ░░███ ░░███ ░░███░░███░░███
             ░███ ░░██████ ░███████ ░███ ░███ ░███  ░███  ░███  ░███ ░███ ░███
             ░███  ░░█████ ░███░░░  ░███ ░███ ░░███ ███   ░███  ░███ ░███ ░███
             █████  ░░█████░░██████ ░░██████   ░░█████    █████ █████░███ █████
            ░░░░░    ░░░░░  ░░░░░░   ░░░░░░     ░░░░░    ░░░░░ ░░░░░ ░░░ ░░░░░
          ]],

          footer = ''',

          content_hooks = {
            require('mini.starter').gen_hook.adding_bullet('» '),
            require('mini.starter').gen_hook.aligning('center', 'center'),
          },
        })
      '';
    };

    mini-sessions = {
      package = pkgs.vimPlugins.mini-sessions;
      setup = ''
        require('mini.sessions').setup({
          hooks = {
            pre = {
              write = function() vim.cmd('Neotree close'); end
            },
          },
        })
      '';
    };
  };
}
