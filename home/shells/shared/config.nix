{
  lib,
  pkgs,
  escalCmd,
  hostName,
  theme,
  flake_path,
}: let
  aliases = let
    shared = {
      gcl = "git clone";
      gs = "git status";
      gc = "git commit";
      ga = "git add";
      gaa = "git add -A";
      gl = "git log";

      top = "btop";

      c = "wl-copy --trim-newline";
    };
  in {
    # WARN: Nushell aliases break on pipes
    nushell = shared;
    almostPOSIX =
      shared
      // {
        l = "ls -ahl";
        ls = "exa";
      };
  };
in
  lib.attrsets.recursiveUpdate {
    home.packages = [
      # HACK: have to use --impure because of being unable to load secrets
      # from their sops-nix generated path in pure mode
      (pkgs.writeShellScriptBin "osu" "${escalCmd} nixos-rebuild switch --impure --flake ${flake_path}/#${hostName}")
      (pkgs.writeShellScriptBin "osr" "${escalCmd} nixos-rebuild switch --impure --rollback --flake ${flake_path}/#${hostName}")

      (pkgs.writeShellScriptBin "use" ''nix shell nixpkgs/nixos-unstable#$1'')
    ];

    programs.bash.shellAliases = aliases.almostPOSIX;
    programs.zsh.shellAliases = aliases.almostPOSIX;
    programs.fish.shellAliases = aliases.almostPOSIX;
    programs.nushell.shellAliases = aliases.nushell;

    programs.carapace = {
      enable = true;
    };

    programs.zoxide = {
      enable = true;
    };

    programs.starship = {
      enable = true;
      enableBashIntegration = false;
    };
  } (import ./themes/${theme} {inherit lib;})
