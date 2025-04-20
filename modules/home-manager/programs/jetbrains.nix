{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib)
    mkEnableOption
    mkPackageOption
    mkOption
    types
    mkIf
    genAttrs
    ;

  cfg = config.programs.jetbrains;

  editors = [
    "aqua"
    "clion"
    "datagrip"
    "dataspell"
    "gateway"
    "goland"
    "idea-community-bin"
    "idea-ultimate"
    "mps"
    "phpstorm"
    "pycharm-community-bin"
    "pycharm-professional"
    "rider"
    "ruby-mine"
    "rust-rover"
    "webstorm"
    "writerside"
  ];
in
{
  options.programs.jetbrains = {
    enable = mkEnableOption "JetBrains editors";

    editors = genAttrs editors (editor: {
      enable = mkEnableOption editor;
      package = mkPackageOption pkgs.jetbrains editor { };
    });

    ideavimrc = mkOption {
      type = with types; nullOr lines;
      description = ''
        Contents written to {file}`$HOME/.ideavimrc`.
      '';
    };
  };

  config = mkIf cfg.enable {
    home.packages = map (
      editor: mkIf cfg.editors.${editor}.enable cfg.editors.${editor}.package
    ) editors;

    home.file.".ideavimrc" = mkIf (cfg.ideavimrc != null) { text = cfg.ideavimrc; };
  };
}
