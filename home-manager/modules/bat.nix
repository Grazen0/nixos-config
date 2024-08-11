{pkgs, ...}: {
  programs.bat = {
    enable = true;
    config = {
      theme = "kanagawa";
    };
    themes = {
      kanagawa = {
        src = pkgs.fetchFromGitHub {
          owner = "rebelot";
          repo = "kanagawa.nvim";
          rev = "e5f7b8a804360f0a48e40d0083a97193ee4fcc87";
          sha256 = "1066495w73a11kdpm8iah3k0pjf766ylf21jk8gjid73byl2lz0n";
        };
        file = "extras/kanagawa.tmTheme";
      };
    };
  };
}
