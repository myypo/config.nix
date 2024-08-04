{pkgs}: {
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
  };
}
