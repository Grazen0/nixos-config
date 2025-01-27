{
  lib,
  buildPythonPackage,
  flit-core,
  mdformat,
  mdformat-gfm,
  mdit-py-plugins,
  mdformat-beautysh,
  mdformat-frontmatter,
  mdformat-ruff,
  mdformat-simple-breaks,
  mdformat-tables,
  mdformat-web,
  mdformat-wikilink,
  setuptools,
  pytestCheckHook,
  pythonOlder,
  src,
}:
buildPythonPackage {
  pname = "mdformat-obsidian";
  version = "master";
  pyproject = true;
  doCheck = false;

  disabled = pythonOlder "3.9";

  inherit src;

  nativeBuildInputs = [flit-core];

  propagatedBuildInputs = [
    mdformat
    mdformat-gfm
    mdit-py-plugins
    mdformat-beautysh
    mdformat-frontmatter
    mdformat-ruff
    mdformat-simple-breaks
    mdformat-tables
    mdformat-web
    mdformat-wikilink
    setuptools
  ];

  nativeCheckInputs = [pytestCheckHook];

  pythonImportsCheck = ["mdformat_obsidian"];

  meta = with lib; {
    description = "Format Markdown for Obsidian including Callouts (Admonitions)";
    homepage = "https://github.com/KyleKing/mdformat-obsidian";
    license = licenses.mit;
  };
}
