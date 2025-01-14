{ pkgs }:
{
  home.packages = with pkgs; [
    nodePackages_latest.typescript
    nodePackages_latest.vscode-langservers-extracted
    vtsls
    prettierd

    nodejs

    tailwindcss-language-server
  ];
}
