{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.git = {
    enable = true;
    userName = "Grazen0";
    userEmail = "josedanielgrayson@proton.me";

    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = true;
      credential.helper = "store";
      core = let
        inherit (config.meta.mainPrograms) editor;
      in {
        editor = lib.mkIf (editor != null) "${editor} -f";
        excludesfile = let
          globalGitignore =
            pkgs.writeText "global-gitignore"
            # gitignore
            ''
              # Vim stuff
              [._]*.s[a-w][a-z]
              [._]s[a-w][a-z]
              Session.vim
              .netrwhist
              *~
              tags
            '';
        in "${globalGitignore}";
      };
      commit.gpgsign = true;
    };
  };
}
