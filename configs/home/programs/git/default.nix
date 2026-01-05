{
  config,
  ...
}:
{
  programs.git = {

    ignores = [
      "Session.vim"
      "*~"
      "*.swp"
      ".direnv/"
    ];

    settings = {
      init.defaultBranch = "main";
      pull.rebase = true;

      commit.gpgsign = true;
      gpg.format = "ssh";

      user = {
        name = "José Daniel Grayson";
        email = "josedanielgrayson@proton.me";
        signingkey = "${config.home.homeDirectory}/.ssh/sign_id_ed25519.pub";
      };
    };
  };
}
