{
  lib,
  pkgs,
  config,
  ...
}:
let
  userOpts = {
    options.file-managers.nemo = {
      enable = lib.makeNullableEnableOption "nemo";
    };
  };
in
{
  options = lib.makeHomeOpts userOpts;

  config = lib.makeHomeModule {
    inherit pkgs config;
    configPath = ./config.nix;
    type = "file-managers";
    name = "nemo";
    addArgsFn = userName: cfg: {
      isMainFileManager = config.myypo.users.${userName}.mainFileManager == "nemo";
    };
  };
}
