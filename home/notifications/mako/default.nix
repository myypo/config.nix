{
  lib,
  pkgs,
  config,
  ...
}:
let
  userOpts = {
    options.notifications.mako = { };
  };
in
{
  options = lib.makeHomeOpts userOpts;

  config = lib.makeHomeModule {
    inherit pkgs config;
    configPath = ./config.nix;
    type = "notifications";
    name = "mako";
    enable = true;
    mkIfFn = cfg: lib.mkIf (cfg._common.enable && cfg._common.backend == "mako");
  };
}
