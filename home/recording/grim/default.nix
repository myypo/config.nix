{
  lib,
  inputs,
  config,
  pkgs,
  ...
}:
let
  userOpts = {
    options.recording.grim = {
      enable = lib.makeNullableEnableOption "grim";
    };
  };
in
{
  options = lib.makeHomeOpts userOpts;

  config = lib.makeHomeModule {
    inherit pkgs config;
    configPath = ./config.nix;
    type = "recording";
    name = "grim";
    addArgsFn = userName: cfg: { inherit inputs; };
  };
}
