{
  lib,
  inputs,
  config,
  pkgs,
  ...
}:
let
  userOpts = {
    options.recording.wf-recorder = {
      enable = lib.makeNullableEnableOption "wf-recorder";
    };
  };
in
{
  options = lib.makeHomeOpts userOpts;

  config = lib.makeHomeModule {
    inherit pkgs config;
    configPath = ./config.nix;
    type = "recording";
    name = "wf-recorder";
    addArgsFn = userName: cfg: { inherit inputs; };
  };
}
