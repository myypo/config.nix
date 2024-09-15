{
  lib,
  theme,
}: {
  programs.nushell = {
    enable = true;

    configFile.source = ./config.nu;
    envFile.source = ./env.nu;
    extraConfig = builtins.readFile ./themes/${theme}/theme.nu;
  };
}
