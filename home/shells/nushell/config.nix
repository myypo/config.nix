{
  lib,
  pkgs,
  theme,
}:
{
  programs.nushell = {
    enable = true;
    package = pkgs.nushell.override { additionalFeatures = p: p ++ [ "system-clipboard" ]; };

    configFile.source = ./config.nu;
    envFile.source = ./env.nu;
    extraConfig = builtins.readFile ./themes/${theme}/theme.nu;
  };

  home.packages = with pkgs; [
    nufmt

    nushellPlugins.query
  ];
}
