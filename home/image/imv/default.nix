{
  lib,
  pkgs,
  config,
  ...
}:
let
  userOpts = {
    options.image.imv = {
      enable = lib.makeNullableEnableOption "imv";
    };
  };
in
{
  options = lib.makeHomeOpts userOpts;

  config = lib.makeHomeModule {
    inherit pkgs config;
    configPath = ./config.nix;
    type = "image";
    name = "imv";
    addArgsFn = userName: cfg: {
      isMainImageViewer = config.myypo.users.${userName}.mainImageViewer == "imv";
    };
  };
}
