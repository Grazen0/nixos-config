{
  src,
  lib,
  buildPythonPackage,
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
  inherit src;

  meta = with lib; {
    description = "Script for managing inkscape figures";
    homepage = "https://github.com/gillescastel/inkscape-figures";
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
