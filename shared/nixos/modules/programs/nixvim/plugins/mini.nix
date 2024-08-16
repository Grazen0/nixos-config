{
  programs.nixvim.plugins.mini = {
    enable = true;

    modules = {
      starter = {
        header = ''
                                  Welcome back to

           ██████   █████                                ███
          ░░██████ ░░███                                ░░░
           ░███░███ ░███   ██████   ██████  █████ █████ ████  █████████████
           ░███░░███░███  ███░░███ ███░░███░░███ ░░███ ░░███ ░░███░░███░░███
           ░███ ░░██████ ░███████ ░███ ░███ ░███  ░███  ░███  ░███ ░███ ░███
           ░███  ░░█████ ░███░░░  ░███ ░███ ░░███ ███   ░███  ░███ ░███ ░███
           █████  ░░█████░░██████ ░░██████   ░░█████    █████ █████░███ █████
          ░░░░░    ░░░░░  ░░░░░░   ░░░░░░     ░░░░░    ░░░░░ ░░░░░ ░░░ ░░░░░
        '';

        footer = "";

        content_hooks.__raw = ''
          {
            require('mini.starter').gen_hook.adding_bullet('» '),
            require('mini.starter').gen_hook.aligning('center', 'center'),
          }
        '';
      };

      sessions = {
        hooks = {
          pre.write.__raw = ''function() vim.cmd("Neotree close"); end'';
          post.read.__raw = ''function() vim.cmd("Neotree filesystem show"); end'';
        };
      };
    };
  };
}
