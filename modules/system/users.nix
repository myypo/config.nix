{
  lib,
  pkgs,
  config,
  ...
}:
with lib; let
  cfg = config.myypo.users;

  userOpts = {
    options.secrets = {
      flake_path = mkEnableOption "absolute path of this flake outside of nix store";

      personal_email = mkEnableOption "personal email secret";
      personal_signing_key = mkEnableOption "personal signing key secret";

      alt_git_identity_list = {
        count = mkOption {
          type = types.int;
          default = 0;
        };

        alias = mkEnableOption "alias name for an alt git id";
        username = mkEnableOption "username of an alt git id";
        email = mkEnableOption "email of an alt git id";
        signing_key = mkEnableOption "signing key of an alt git id";
      };
    };

    options.mainShell = mkOption {
      type = types.str;
    };

    options.fontSize = mkOption {
      type = types.nullOr types.int;
    };
    options.theme = mkOption {
      type = types.nullOr types.str;
    };

    options.githubUserName = mkOption {
      type = types.nullOr types.str;
    };

    options.mainEditor = mkOption {
      type = types.nullOr types.str;
    };
    options.mainBrowser = mkOption {
      type = types.nullOr types.str;
    };
    options.mainTerminal = mkOption {
      type = types.nullOr types.str;
    };
    options.mainFileManager = mkOption {
      type = types.nullOr types.str;
    };
    options.mainDocumentViewer = mkOption {
      type = types.nullOr types.str;
    };
    options.mainImageViewer = mkOption {
      type = types.nullOr types.str;
    };
    options.mainVideoPlayer = mkOption {
      type = types.nullOr types.str;
    };
    options.mainMusicPlayer = mkOption {
      type = types.nullOr types.str;
    };
  };

  users =
    {root.hashedPasswordFile = config.sops.secrets.root_password.path;}
    // (builtins.mapAttrs (
        userName: cfg: {
          isNormalUser = true;
          hashedPasswordFile = config.sops.secrets."${userName}_password".path;
          shell = pkgs.${cfg.mainShell};

          extraGroups = ["wheel" "docker" "libvirtd" "video" "audio"];
        }
      )
      cfg);

  enabledShells =
    lib.attrsets.concatMapAttrs (
      _: cfg: {
        "${cfg.mainShell}" = {enable = true;};
      }
    )
    cfg;

  permittedShells =
    lib.attrsets.mapAttrsToList (
      _: cfg: pkgs.${cfg.mainShell}
    )
    cfg;

  setSubOpts = {
    lib,
    userOpts,
  }:
    with lib; {
      myypo.users = mkOption {
        type = types.attrsOf (types.submodule userOpts);
      };
    };
in {
  options = setSubOpts {inherit lib userOpts;};

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
