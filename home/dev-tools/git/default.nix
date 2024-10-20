{
  lib,
  pkgs,
  config,
  ...
}: let
  userOpts = {
    options.dev-tools.git = {
      enable = lib.makeNullableEnableOption "git";

      githubUserName = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
      };
    };
  };
in {
  options = lib.makeHomeOpts userOpts;

  config = lib.makeHomeModule {
    inherit pkgs config;
    configPath = ./config.nix;
    type = "dev-tools";
    name = "git";
    addArgsFn = userName: cfg: {
      alt_git_identity_list = lib.getUserListSecret {
        inherit config userName;
        listSecretName = "alt_git_identity_list";
      };
    };
  };
}
