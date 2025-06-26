{ pkgs }:
{
  home.packages = with pkgs; [
    slack
    google-chrome
    postman
    keepassxc
  ];
}
