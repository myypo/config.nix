{
  pkgs,
  escalCmd,
  hostName,
  theme,
  flake_path,
}: {
  programs.fish.enable = true;

  home.packages = with pkgs; [
    fishPlugins.puffer
  ];

  ### Theme ###
  # Numbers are used to ensure correct ordering of sourcing
  home.file.".config/fish/conf.d/0${theme}_palette.fish".source = ./themes/${theme}/palette.fish;

  ### Other fish settings ###
  home.file.".config/fish/conf.d/common.fish".source = ./settings/common.fish;

  ### Utility functions ###
  # Enter local dev nix shell
  home.file.".config/fish/functions/dev.fish".source = ./functions/dev.fish;
  home.file.".config/fish/functions/eisvogel.fish".source = ./functions/eisvogel.fish;
  # Save image from clipboard to disk
  home.file.".config/fish/functions/clipng.fish".source = ./functions/clipng.fish;
  # Stash the dev env flake related files for working with people who haven't joined the cult
  home.file.".config/fish/functions/stash-flake.fish".source = ./functions/stash-flake.fish;
  # Remove all current Docker containers
  home.file.".config/fish/functions/downdock.fish".source = ./functions/downdock.fish;

  # Utils for quickly creating and opening git repos
  home.file.".config/fish/functions/t.fish".source = ./functions/t.fish;
  home.file.".config/fish/functions/t-new-term.fish".source = ./functions/t-new-term.fish;
  home.file.".config/fish/functions/tinit.fish".source = ./functions/tinit.fish;
  home.file.".config/fish/functions/tinit-new-term.fish".source = ./functions/tinit-new-term.fish;
  home.file.".config/fish/functions/b.fish".source = ./functions/b.fish;

  ### Events ###
  home.file.".config/fish/conf.d/postexecnotify.fish".source = ./events/postexecnotify.fish;
}
