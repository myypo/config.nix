{
  pkgs,
  theme,
  fontSize,
}:
{
  imports = [ (import ./themes/${theme} { inherit fontSize; }) ];

  services.mako = {
    enable = true;
  };

  home.packages = with pkgs; [ libnotify ];
}
