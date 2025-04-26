{ pkgs }:
{
  home.packages = with pkgs; [
    gopls
    gofumpt
    golines
    gotests
    gomodifytags
    gotools
    iferr
    delve
    golangci-lint
    golangci-lint-langserver
  ];

  programs.go = {
    enable = true;
  };
}
