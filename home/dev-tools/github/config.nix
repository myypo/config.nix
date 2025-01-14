{ theme, pkgs }:
{
  programs.gh = {
    enable = true;
  };

  programs.gh-dash = {
    enable = true;

    settings = {
      theme = import ./themes/${theme};
    };
  };

  home.packages = with pkgs; [ act ];
}
