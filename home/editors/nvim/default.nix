{
  lib,
  inputs,
  pkgs,
  config,
  ...
}:
with lib; let
  nixosConfig = config;

  cfgs = lib.getCfgs {
    inherit config;
    type = "editors";
    name = "nvim";
  };
  enable = lib.cfgIsEnabled {
    inherit config;
    type = "editors";
    name = "nvim";
  };

  userOpts = {
    options.editors.nvim = {
      enable = lib.mkNullableEnableOption "nvim";

      theme = mkOption {
        type = types.nullOr types.str;
        default = null;
      };
    };
  };
in {
  options = lib.setSubOpts {inherit userOpts;};

  config = mkIf enable {
    home-manager.users =
      builtins.mapAttrs (
        userName: cfg:
          lib.mkIfFall cfg (
            # TODO: there is probably a better way of making the home-manager lib accessible
            {config, ...}: let
              homeManagerConfig = config;
            in
              import ./config.nix {
                lib = homeManagerConfig.lib // lib;
                inherit inputs pkgs;

                flake_path = lib.getUserSecret {
                  config = nixosConfig;
                  inherit userName;
                  secretName = "flake_path";
                };

                theme = lib.valueOrUserDefault {
                  inherit userName;
                  config = nixosConfig;
                  name = "theme";
                  val = cfg.theme;
                };

                isMainEditor = nixosConfig.myypo.users.${userName}.mainEditor == "nvim";

                githubUserName = nixosConfig.myypo.users.${userName}.githubUserName;
              }
          )
      )
      cfgs;

    nixpkgs.overlays = [inputs.neovim-nightly-overlay.overlays.default];
  };
}
