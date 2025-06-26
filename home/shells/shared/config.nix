{
  lib,
  pkgs,
  escalCmd,
  hostName,
  theme,
  flakePath,
}:
let
  aliases =
    let
      shared = {
        gcl = "git clone";
        gs = "git status";
        gc = "git commit";
        ga = "git add";
        gaa = "git add -A";
        gl = "git log";

        top = "btop";

        c = "wl-copy --trim-newline";

        r = "bat";

        p = "pueue";
        pa = "pueue add -i";
        pr = "pueue reset -f";
        pk = "pueue kill";
        pl = "pueue log";
      };
    in
    {
      # WARN: Nushell aliases break on pipes
      nushell = shared;
      almostPOSIX = shared // {
        b = "cd $PROJ_PATH";
        l = "ls -ahl";
        ls = "exa";
      };
    };
in
lib.attrsets.recursiveUpdate (import ./themes/${theme} { inherit lib; }) {
  home.packages = [
    # WARN: have to use --impure for mkOutOfStoreSymlink
    (pkgs.writeShellScriptBin "osu" "${escalCmd} nixos-rebuild switch --impure --flake ${flakePath}/#${hostName}")
    (pkgs.writeShellScriptBin "osr" "${escalCmd} nixos-rebuild switch --impure --rollback --flake ${flakePath}/#${hostName}")
    (pkgs.writeShellScriptBin "ost" "${escalCmd} nixos-rebuild test --impure --flake ${flakePath}/#${hostName}")

    (pkgs.writeShellScriptBin "u" ''nix shell nixpkgs/nixos-unstable#$1'')

    (pkgs.writeShellScriptBin "nr" ''nix run .#$1'')
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
}
