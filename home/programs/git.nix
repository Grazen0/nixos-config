{config, ...}: {
  programs.git = {
    enable = true;
    userName = "Grazen0";
    userEmail = "josedanielgrayson@proton.me";

    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = true;
      credential.helper = "store";
      core.editor = "${config.meta.mainPrograms.editor} -f";
      commit.gpgsign = true;
    };
  };
}
