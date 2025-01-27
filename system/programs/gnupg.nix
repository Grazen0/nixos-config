{
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    settings = {
      # 7 days
      default-cache-ttl = 604800;
      max-cache-ttl = 604800;
    };
  };
}
