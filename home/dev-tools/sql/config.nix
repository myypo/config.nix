{ pkgs }:
{
  home.packages = with pkgs; [
    sqlfluff

    postgres-lsp
  ];
}
