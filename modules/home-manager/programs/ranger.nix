{pkgs, ...}: {
  programs.ranger = {
    enable = true;

    plugins = [
      {
        name = "ranger_devicons";
        src = pkgs.fetchFromGitHub {
          owner = "alexanderjeurissen";
          repo = "ranger_devicons";
          rev = "a8d626485ca83719e1d8d5e32289cd96a097c861";
          sha256 = "0i5c7xl8fcbxr08m7h59xf663ab1rabqfrf5h7ihjpl3azvcwa5j";
        };
      }
    ];

    settings = {
      automatically_count_files = true;

      vcs_aware = true;
      vcs_backend_git = "enabled";

      preview_images = true;
      preview_images_method = "sixel";

      status_bar_on_top = true;
      draw_progress_bar_in_status_bar = true;

      draw_borders = "both";
      dirname_in_tabs = true;

      line_numbers = "relative";
      relative_current_zero = true;

      wrap_scroll = true;

      nested_ranger_warning = true;
    };

    extraConfig = ''
      default_linemode devicons
    '';
  };

  programs.pistol = {
    enable = true;

    associations = [
      {
        mime = "application/json";
        command = "bat %pistol-filename%";
      }
    ];
  };
}
