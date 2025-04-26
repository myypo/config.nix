{ pkgs }:
{
  home.packages = with pkgs; [
    texliveBasic
    pandoc
  ];
}
