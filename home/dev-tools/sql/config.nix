{ pkgs }:
{
  home.packages = with pkgs; [
    sqlfluff

    # TODO: sounds good but it just crashes all the time
    # postgres-lsp
  ];
}
