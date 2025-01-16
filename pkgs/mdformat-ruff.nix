{
  lib,
  buildPythonPackage,
  poetry-core,
  mdformat,
  ruff,
  pytestCheckHook,
  pythonOlder,
  src,
}:
buildPythonPackage {
  pname = "mdformat-ruff";
  version = "0.1.3";
  pyproject = true;

  disabled = pythonOlder "3.7";

  inherit src;

  nativeBuildInputs = [poetry-core];

  propagatedBuildInputs = [
    mdformat
    ruff
  ];

  nativeCheckInputs = [pytestCheckHook];

  pythonImportsCheck = ["mdformat_ruff"];

  meta = with lib; {
    description = "Mdformat plugin to Blacken Python code blocks";
    homepage = "https://github.com/Freed-Wu/mdformat-ruff";
    license = licenses.mit;
  };
}
