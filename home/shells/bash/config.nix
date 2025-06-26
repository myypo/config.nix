{ pkgs }:
{
  programs.bash = {
    enable = true;
  };
  home.packages = with pkgs; [
    nodePackages_latest.bash-language-server
    shellcheck
    shfmt
  ];
}
