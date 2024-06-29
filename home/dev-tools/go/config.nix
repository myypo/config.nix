{pkgs}: let
  go111Mod = "on";
  goModCache = "$HOME/.go/pkg/mod";
in {
  home.sessionVariables = {
    GO111MODULE = go111Mod;
    GOMODCACHE = goModCache;
  };
  home.sessionPath = [
    "$HOME/.go/bin"
  ];
  home.packages = with pkgs; [
    gopls
    gofumpt
    golines
    gotests
    gomodifytags
    gotools
    impl
    iferr
    gonstructor
    delve
  ];

  programs.go = {
    enable = true;
    goPath = ".go";
  };
}
