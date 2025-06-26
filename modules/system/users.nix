{
  lib,
  pkgs,
  config,
  ...
}:
with lib;
let
  cfg = config.myypo.users;

  userOpts = {
    # Potentially confidential
    options = {
      flakePath = mkOption {
        type = types.str;
        description = "absolute path of this flake outside of nix store";
      };

      personalEmail = mkOption { type = types.str; };
      personalSigningKey = mkOption { type = types.str; };

      altGitIdentities = mkOption {
        type = types.attrsOf (
          types.submodule {
            options = {
              username = mkOption { type = types.str; };
              email = mkOption { type = types.str; };
              signingKey = mkOption { type = types.nullOr types.str; };
            };
          }
        );
      };
    };

    options.mainShell = mkOption { type = types.str; };

    options.fontSize = mkOption { type = types.nullOr types.int; };
    options.theme = mkOption { type = types.nullOr types.str; };

    options.githubUserName = mkOption { type = types.nullOr types.str; };

    options.mainEditor = mkOption { type = types.nullOr types.str; };
    options.mainBrowser = mkOption { type = types.nullOr types.str; };
    options.mainTerminal = mkOption { type = types.nullOr types.str; };
    options.mainFileManager = mkOption { type = types.nullOr types.str; };
    options.mainDocumentViewer = mkOption { type = types.nullOr types.str; };
    options.mainImageViewer = mkOption { type = types.nullOr types.str; };
    options.mainVideoPlayer = mkOption { type = types.nullOr types.str; };
    options.mainMusicPlayer = mkOption { type = types.nullOr types.str; };
  };

  users =
    {
      root.hashedPasswordFile = config.sops.secrets.root_password.path;
    }
    // (builtins.mapAttrs (userName: cfg: {
      isNormalUser = true;
      hashedPasswordFile = config.sops.secrets."${userName}_password".path;
      shell = pkgs.${cfg.mainShell};

      extraGroups = [
        "wheel"
        "docker"
        "libvirtd"
        "video"
        "audio"
      ];
    }) cfg);

  enabledShells = lib.attrsets.concatMapAttrs (_: cfg: {
    "${cfg.mainShell}" = {
      enable = true;
    };
  }) cfg;

  permittedShells = lib.attrsets.mapAttrsToList (_: cfg: pkgs.${cfg.mainShell}) cfg;

  makeHomeOpts =
    { lib, userOpts }:
    with lib;
    {
      myypo.users = mkOption { type = types.attrsOf (types.submodule userOpts); };
    };
in
{
  options = makeHomeOpts { inherit lib userOpts; };

  config = {
    users.mutableUsers = false;
    users.users = users;

    programs = enabledShells;

    environment = {
      shells = permittedShells;

      binsh = "${pkgs.dash}/bin/dash";
    };
  };
}
