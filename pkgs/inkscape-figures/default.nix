{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  fetchPypi,
  pythonOlder,
  setuptools,
  wheel,
  pyperclip,
  click,
  appdirs,
  daemonize,
  inotify,
  ...
}:
buildPythonPackage {
  pname = "inkscape-figures";
  version = "1.0.7";

  src = fetchFromGitHub {
    owner = "gillescastel";
    repo = "inkscape-figures";
    rev = "02deea60751102641a7d6d9c6e8b535c0255f2eb";
    sha256 = "1v38q9hyiz1lmzv0v4422yqhky377lvjbb09s99p44ph6kzx4fgb";
  };

  meta = with lib; {
    homepage = "https://github.com/gillescastel/inkscape-figures";
    description = "Script for managing inkscape figures";
    license = licenses.mit;
  };

  pyproject = true;
  build-system = [
    setuptools
    wheel
  ];

  dependencies = [
    pyperclip
    click
    appdirs
    daemonize
    inotify
  ];
}
