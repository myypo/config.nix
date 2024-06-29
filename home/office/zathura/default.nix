{
  lib,
  config,
  ...
}: let
  cfgs = lib.getCfgs {
    inherit config;
    type = "office";
    name = "zathura";
  };

  userOpts = {
    options.office.zathura = {
      enable = lib.mkNullableEnableOption "zathura";
    };
  };
in {
  options = lib.setSubOpts {inherit userOpts;};

  config.home-manager.users =
    builtins.mapAttrs (
      userName: cfg:
        lib.mkIfFall cfg (import ./config.nix {
          inherit lib;

          isMainDocumentViewer = config.myypo.users.${userName}.mainDocumentViewer == "zathura";
        })
    )
    cfgs;
}
