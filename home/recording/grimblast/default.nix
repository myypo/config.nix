{
  lib,
  inputs,
  config,
  pkgs,
  ...
}:
let
  userOpts = {
    options.recording.grimblast = {
      enable = lib.makeNullableEnableOption "grimblast";
    };
  };
in
{
  options = lib.makeHomeOpts userOpts;

  config = lib.makeHomeModule {
    inherit pkgs config;
    configPath = ./config.nix;
    type = "recording";
    name = "grimblast";
    addArgsFn = userName: cfg: { inherit inputs; };
  };
}
