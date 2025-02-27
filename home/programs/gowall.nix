{
  config,
  lib,
  ...
}: {
  programs.gowall = {
    enable = true;

    extraConfig.themes = [
      {
        name = "kanagawa";
        colors = lib.attrValues config.theme.colors.hexWithHashtag;
      }
    ];
  };
}
