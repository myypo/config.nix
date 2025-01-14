{
  lib,
  pkgs,
  config,
  ...
}:
let
  userOpts = {
    options.recording.obs = {
      enable = lib.makeNullableEnableOption "obs";
    };
  };
in
{
  options = lib.makeHomeOpts userOpts;

  config = lib.makeHomeModule {
    inherit pkgs config;
    configPath = ./config.nix;
    type = "recording";
    name = "obs";
  };
}
