{
  lib,
  stdenv,
  fetchFromGitHub,
}:
stdenv.mkDerivation {
  pname = "aphrodite-terminal-theme";
  version = "2024-03-19";

  src = fetchFromGitHub {
    owner = "win0err";
    repo = "aphrodite-terminal-theme";
    rev = "2c9e4c95ec34fbe32500f39c3f99cedb530a52f7";
    sha256 = "14zckxarajhqzcps7hq05gcmmqcy3c0f0xpfa2vadjb6hl66mvks";
  };

  strictDeps = true;
  installPhase = ''
    install -Dm0644 aphrodite.theme.sh --target-directory=$out/share/bash/themes
    install -Dm0644 aphrodite.zsh-theme --target-directory=$out/share/zsh/themes
    install -Dm0644 fish_prompt.fish --target-directory=$out/share/fish/functions
  '';

  meta = with lib; {
    description = "A minimalistic terminal theme (prompt) for sexy terminals that works in bash, fish and zsh.";
    homepage = "https://github.com/win0err/aphrodite-terminal-theme";
    license = licenses.mit;
    platforms = platforms.all;
    maintainers = [];
  };
}
