{
  config,
  lib,
  pkgs,
  ...
}:
{
  programs.git = {
    userName = "José Daniel Grayson";
    userEmail = "josedanielgrayson@proton.me";

    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = true;

      commit.gpgsign = true;
      gpg.format = "ssh";
      user.signingkey = "${config.home.homeDirectory}/.ssh/sign_id_ed25519.pub";

      core =
        let
          inherit (config.meta.mainPrograms) editor;
        in
        {
          editor = lib.mkIf (editor != null) "${editor} -f";
          excludesfile =
            let
              globalGitignore = pkgs.writeText "global-gitignore" ''
                Session.vim
              '';
            in
            "${globalGitignore}";
        };
    };
  };
}
