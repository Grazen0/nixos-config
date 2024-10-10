{
  vimUtils,
  fetchFromGitHub,
}:
vimUtils.buildVimPlugin {
  pname = "multicursor.nvim";
  version = "2024-10-09";
  src = fetchFromGitHub {
    owner = "jake-stewart";
    repo = "multicursor.nvim";
    rev = "57f83ac0c26e93e280ea344b2099d69340e41d88";
    sha256 = "1qsdxk6wch7yv4dp6zhmc0mf8lls2r2vwir2hwapyvlg4sf58fc6";
  };
  meta.homepage = "https://github.com/jake-stewart/multicursors.nvim/";
}
