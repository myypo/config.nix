{pkgs}: {
  home.packages = with pkgs; [
    nodePackages_latest.typescript
    nodePackages_latest.typescript-language-server
    nodePackages_latest.vscode-langservers-extracted
    prettierd

    nodejs
  ];
}
