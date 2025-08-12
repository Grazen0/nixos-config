{
  programs.direnv = {
    nix-direnv.enable = true;
    config = {
      global.load_dotenv = true;
    };
  };
}
