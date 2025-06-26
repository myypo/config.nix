{
  lib,
  pkgs,
  config,
  ...
}:
let
  userOpts = {
    options.office.zathura = {
      enable = lib.makeNullableEnableOption "zathura";
    };
  };
in
{
  options = lib.makeHomeOpts userOpts;

  config = lib.makeHomeModule {
    inherit pkgs config;
    configPath = ./config.nix;
    type = "office";
    name = "zathura";
    addArgsFn = userName: cfg: {
      isMainDocumentViewer = config.myypo.users.${userName}.mainDocumentViewer == "zathura";
    };
  };
}
