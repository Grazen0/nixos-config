{pkgs, ...}: {
  home.packages = with pkgs; [zapzap];

  xdg.configFile."ZapZap/ZapZap.conf".text = ''
    [notification]
    app=true

    [storage-whats]
    notification=true

    [system]
    background_message=true
    donation_message=false
    folderDownloads=true
    hide_bar_users=true
    theme=dark
  '';
}
