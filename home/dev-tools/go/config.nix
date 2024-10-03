{pkgs}: {
  home.packages = with pkgs; [
    gopls
    gofumpt
    golines
    gotests
    gomodifytags
    gotools
    iferr
    delve
  ];

  programs.go = {
    enable = true;
  };
}
