{
  lib,
  inputs,
  pkgs,
  config,
  ...
}:
let
  userOpts = {
    options.dev-tools.rust = {
      enable = lib.makeNullableEnableOption "rust dev-tools";
    };
  };
in
{
  options = lib.makeHomeOpts userOpts;

  config = lib.makeHomeModule {
    inherit pkgs config;
    configPath = ./config.nix;
    type = "dev-tools";
    name = "rust";
    nixosConfig = {
      nixpkgs.overlays = [
        inputs.fenix.overlays.default
      ];
    };
  };
}
