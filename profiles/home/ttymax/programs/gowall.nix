{
  config,
  lib,
  ...
}: {
  programs.gowall = {
    extraConfig.themes = [
      {
        name = "kanagawa";
        colors = lib.attrValues config.theme.colors.hexWithHashtag;
      }
    ];
  };
}
