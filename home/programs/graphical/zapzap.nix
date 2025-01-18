{
  programs.zapzap = {
    enable = false;

    settings = {
      notification.app = true;

      storage-whats.notification = true;

      system = {
        background_message = true;
        donation_message = false;
        folderDownloads = true;
        hide_bar_users = true;
        theme = "dark";
      };

      website = {
        open_page = false;
      };
    };
  };
}
