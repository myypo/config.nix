{
  lib,
  config,
  ...
}: let
  cfgs = lib.getCfgs {
    inherit config;
    type = "dev-tools";
    name = "git";
  };

  userOpts = {
    options.dev-tools.git = {
      enable = lib.mkNullableEnableOption "git";

      personalUserName = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
      };
    };
  };
in {
  options = lib.setSubOpts {inherit userOpts;};

  config.home-manager.users =
    (builtins.mapAttrs (
        userName: cfg:
          with cfg;
            lib.mkIfFall cfg (import ./config.nix {
              inherit lib;

              personalUserName = lib.valueOrUserDefault {
                inherit config userName;
                name = "githubUserName";
                val = personalUserName;
              };

              personal_signing_key = lib.getUserSecret {
                inherit config userName;
                secretName = "personal_signing_key";
              };
              personal_email = lib.getUserSecret {
                inherit config userName;
                secretName = "personal_email";
              };

              alt_git_identity_list = lib.getUserListSecret {
                inherit config userName;
                listSecretName = "alt_git_identity_list";
              };
            })
      )
      cfgs)
    # HACK: this regression happened again: https://github.com/NixOS/nix/issues/10202
    // {
      root.programs.git = {
        enable = true;
        extraConfig.safe.directory = builtins.map (userName: "/home/${userName}/code/my/dots/flake") (builtins.attrNames cfgs);
      };
    };
}
