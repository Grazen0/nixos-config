{
  lib,
  buildPythonPackage,
  poetry-core,
  markdown-it-py,
  mdformat,
  # pytestCheckHook,
  pythonOlder,
  src,
}:
buildPythonPackage {
  pname = "mdformat-wikilink";
  version = "0.2.0";
  pyproject = true;

  disabled = pythonOlder "3.8";

  inherit src;

  nativeBuildInputs = [poetry-core];

  propagatedBuildInputs = [
    markdown-it-py
    mdformat
  ];

  # nativeCheckInputs = [pytestCheckHook];

  # pythonImportsCheck = ["mdformat_wikilink"];

  meta = with lib; {
    description = "Add wiki-style link support to mdformat.";
    homepage = "https://github.com/tmr232/mdformat-wikilink";
    license = licenses.mit;
  };
}
