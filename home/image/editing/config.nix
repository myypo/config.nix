{ pkgs }:
{
  home.packages = with pkgs; [
    imagemagick
    gimp
  ];
}
