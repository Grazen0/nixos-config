{pkgs, ...}: {
  programs.foot = {
    enable = true;
    server.enable = false;

    settings = let
      kanagawa = pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/rebelot/kanagawa.nvim/refs/heads/master/extras/foot_kanagawa.ini";
        sha256 = "0r8v3scj9zgkv5lxhgyd7wbp1liy8mlj5pczxf5f1ykmish531h5";
      };
    in {
      main = {
        font = "JetBrainsMonoNL Nerd Font:size=9.5:weight=semibold";
        include = "${kanagawa}";
      };

      mouse.hide-when-typing = "yes";
      cursor.color = "1f1f28 c8c093";

      scrollback.lines = 10000;
    };
  };
}
