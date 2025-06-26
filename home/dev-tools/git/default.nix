{
  lib,
  pkgs,
  config,
  ...
}:
let
  userOpts = {
    options.dev-tools.git = {
      enable = lib.makeNullableEnableOption "git";

      githubUserName = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
      };
    };
  };
in
{
  options = lib.makeHomeOpts userOpts;

  config = lib.makeHomeModule {
    inherit pkgs config;
    configPath = ./config.nix;
    type = "dev-tools";
    name = "git";
  };
}
