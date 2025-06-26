{
  pkgs,
  escalCmd,
  hostName,
  theme,
  flakePath,
}:
{
  programs.fish.enable = true;
  programs.fish.shellInitLast = builtins.readFile ./settings/common.fish;

  home.packages = with pkgs; [ fishPlugins.puffer ];

  ### Theme ###
  # Numbers are used to ensure correct ordering of sourcing
  xdg.configFile."fish/conf.d/0${theme}_palette.fish".source = ./themes/${theme}/palette.fish;

  ### Utility functions ###
  # Enter local dev nix shell
  xdg.configFile."fish/functions/dev.fish".source = ./functions/dev.fish;
  xdg.configFile."fish/functions/eisvogel.fish".source = ./functions/eisvogel.fish;
  # Save image from clipboard to disk
  xdg.configFile."fish/functions/clipng.fish".source = ./functions/clipng.fish;
  # Stash the dev env flake related files for working with people who haven't joined the cult
  xdg.configFile."fish/functions/stash-flake.fish".source = ./functions/stash-flake.fish;
  # Remove all current Docker containers
  xdg.configFile."fish/functions/downdock.fish".source = ./functions/downdock.fish;

  # Utils for quickly creating and opening git repos
  xdg.configFile."fish/functions/t.fish".source = ./functions/t.fish;
  xdg.configFile."fish/functions/t-new-term.fish".source = ./functions/t-new-term.fish;
  xdg.configFile."fish/functions/tinit.fish".source = ./functions/tinit.fish;
  xdg.configFile."fish/functions/tinit-new-term.fish".source = ./functions/tinit-new-term.fish;

  ### Events ###
  xdg.configFile."fish/conf.d/postexecnotify.fish".source = ./events/postexecnotify.fish;
}
