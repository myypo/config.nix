{ pkgs }:
{
  home.packages = with pkgs; [ typos-lsp ];

  xdg.configFile."typos.toml".source = ./typos.toml;
}
