{
  lib,
  buildPythonPackage,
  flit-core,
  mdformat,
  mdit-py-plugins,
  mdformat-tables,
  mdformat-frontmatter,
  mdformat-footnote,
  ruamel-yaml,
  pytestCheckHook,
  pythonOlder,
  src,
}:
buildPythonPackage {
  pname = "mdformat-myst";
  version = "master";
  pyproject = true;

  disabled = pythonOlder "3.7";

  inherit src;

  nativeBuildInputs = [flit-core];

  propagatedBuildInputs = [
    mdformat
    mdit-py-plugins
    mdformat-tables
    mdformat-frontmatter
    mdformat-footnote
    ruamel-yaml
  ];

  nativeCheckInputs = [pytestCheckHook];

  pythonImportsCheck = ["mdformat_myst"];

  meta = with lib; {
    description = "Mdformat plugin for MyST compatibility";
    homepage = "https://github.com/executablebooks/mdformat-myst";
    license = licenses.mit;
  };
}
