{
  config,
  ...
}:
{
  programs.git = {
    userName = "José Daniel Grayson";
    userEmail = "josedanielgrayson@proton.me";

    ignores = [
      "Session.vim"
      "*~"
      "*.swp"
    ];

    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = true;

      commit.gpgsign = true;
      gpg.format = "ssh";
      user.signingkey = "${config.home.homeDirectory}/.ssh/sign_id_ed25519.pub";
    };
  };
}
