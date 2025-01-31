{
  config,
  lib,
  pkgs,
  ...
}: {
  # Just creates desktop entries for the games
  xdg.dataFile = let
    mkTouhou = {
      game,
      fullName,
      path ? "${config.home.homeDirectory}/Games/Touhou ${game}",
      exec ? null,
    }: let
      paddedGame = lib.strings.fixedWidthString 2 "0" game;
      actualExec =
        if isNull exec
        then "th${paddedGame} (thpatch-en).exe"
        else exec;
    in {
      text = ''
        [Desktop Entry]
        Type=Application
        Name=Touhou ${game} - ${fullName}
        GenericName=Touhou ${game}
        Path=${path}
        Exec=${pkgs.wine}/bin/wine '${actualExec}'
        Icon=${../../../files/touhou/th${paddedGame}.png}
      '';
    };

    touhous = [
      {
        game = "6";
        fullName = "The Embodiment of Scarlet Devil";
      }
      {
        game = "7";
        fullName = "Perfect Cherry Blossom";
      }
      {
        game = "8";
        fullName = "Imperishable Night";
      }
      {
        game = "10";
        fullName = "Mountain of Faith";
      }
      {
        game = "11";
        fullName = "Subterranean Animism";
      }
    ];
  in
    lib.listToAttrs (map (th: {
        name = "applications/th${th.game}.desktop";
        value = mkTouhou th;
      })
      touhous);
}
