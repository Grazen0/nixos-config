{
  lib,
  buildPythonPackage,
  poetry-core,
  mdformat,
  jsbeautifier,
  cssbeautifier,
  beautifulsoup4,
  pytestCheckHook,
  pythonOlder,
  src,
}:
buildPythonPackage {
  pname = "mdformat-web";
  version = "0.2.0";
  pyproject = true;

  disabled = pythonOlder "3.9";

  inherit src;

  nativeBuildInputs = [poetry-core];

  propagatedBuildInputs = [
    mdformat
    jsbeautifier
    cssbeautifier
    beautifulsoup4
  ];

  nativeCheckInputs = [pytestCheckHook];

  pythonImportsCheck = ["mdformat_web"];

  meta = with lib; {
    description = "Mdformat plugin to format JS, CSS, HTML and XML code blocks";
    homepage = "https://github.com/hukkin/mdformat-web";
    license = licenses.mit;
  };
}
