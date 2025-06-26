{ pkgs }:
{
  home.packages = with pkgs; [ xdg-utils ];

  xdg = {
    enable = true;

    mimeApps.enable = true;
  };
}
