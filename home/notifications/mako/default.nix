{
  lib,
  pkgs,
  config,
  ...
}:
with lib; let
  cfgs = lib.getCfgs {
    inherit config;
    type = "notifications";
    name = "mako";
  };

  userOpts = {
    options.notifications.mako = {};
  };
in {
  options = lib.setSubOpts {inherit userOpts;};

  config = {
    home-manager.users =
      builtins.mapAttrs (
        userName: cfg: let
          enable = cfg._common.enable;

          backend = cfg._common.backend;
          isBackend = backend == "mako";

          theme = cfg._common.theme;

          fontSize = cfg._common.fontSize;
        in
          with cfg;
            mkIf (enable && isBackend) (import ./config.nix {
              inherit pkgs;

              theme = lib.valueOrUserDefault {
                inherit config userName;
                name = "theme";
                val = theme;
              };
              fontSize = lib.valueOrUserDefault {
                inherit config userName;
                name = "fontSize";
                val = fontSize;
              };
            })
      )
      cfgs;
  };
}
