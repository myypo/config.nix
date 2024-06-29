{
  pkgs,
  escalCmd,
  hostName,
  theme,
  flake_path,
}: {
  programs.fish = {
    enable = true;

    shellAliases = {
      v = "kitty @ launch --copy-env --spacing padding=0 --cwd=current --type=tab nvim >/dev/null 2>&1";

      gcl = "git clone";
      gs = "git status";
      gc = "git commit";
      ga = "git add";
      gaa = "git add -A";
      gl = "git log";
      reposquash = "git reset $(git commit-tree HEAD^{tree} -m 'initial commit')";

      l = "ls -ahl";
      ls = "exa";

      top = "btop";

      # HACK: have to use --impure because of being unable to load secrets
      # from their sops-nix generated path in pure mode
      osu = "${escalCmd} nixos-rebuild switch --impure --flake ${flake_path}/#${hostName}";
      osr = "${escalCmd} nixos-rebuild switch --impure --rollback --flake ${flake_path}/#${hostName}";

      n = "neofetch";

      f = "fzf";

      c = "wl-copy";
    };
  };

  home.packages = with pkgs; [
    fishPlugins.puffer
  ];

  ### Theme and prompt ###
  # Numbers are used to ensure correct ordering of sourcing
  home.file.".config/fish/conf.d/0${theme}_palette.fish".source = ./themes/${theme}/palette.fish;
  home.file.".config/fish/conf.d/1${theme}_prompt.fish".source = ./themes/${theme}/prompt.fish;

  home.file.".config/fish/conf.d/hydro.fish".source = ./settings/hydro.fish;
  home.file.".config/fish/functions/fish_prompt.fish".source = ./settings/fish_prompt.fish;

  ### Other fish settings ###
  home.file.".config/fish/conf.d/common.fish".source = ./settings/common.fish;

  ### Utility functions ###
  # Enter local dev nix shell
  home.file.".config/fish/functions/dev.fish".source = ./functions/dev.fish;
  home.file.".config/fish/functions/eisvogel.fish".source = ./functions/eisvogel.fish;
  # Save image from clipboard to disk
  home.file.".config/fish/functions/clipng.fish".source = ./functions/clipng.fish;

  # Utils for quickly creating and opening git repos
  home.file.".config/fish/functions/t.fish".source = ./functions/t.fish;
  home.file.".config/fish/functions/t-new-term.fish".source = ./functions/t-new-term.fish;
  home.file.".config/fish/functions/tinit.fish".source = ./functions/tinit.fish;
  home.file.".config/fish/functions/tinit-new-term.fish".source = ./functions/tinit-new-term.fish;
  home.file.".config/fish/functions/b.fish".source = ./functions/b.fish;

  ### Events ###
  home.file.".config/fish/conf.d/postexecnotify.fish".source = ./events/postexecnotify.fish;
}
