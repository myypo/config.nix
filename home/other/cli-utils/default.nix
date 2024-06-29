{
  lib,
  pkgs,
  config,
  ...
}:
with lib; let
  cfgs = lib.getCfgs {
    inherit config;
    type = "other";
    name = "cli-utils";
  };

  userOpts = {
    options.other.cli-utils = {
      enable = lib.mkNullableEnableOption "misc cli tools";

      theme = mkOption {
        type = types.nullOr types.str;
        default = null;
      };
    };
  };
in {
  options = lib.setSubOpts {inherit userOpts;};

  config.home-manager.users = builtins.mapAttrs (userName: cfg: let
    finalTheme = lib.valueOrUserDefault {
      inherit config userName;
      name = "theme";
      val = cfg.theme;
    };
  in
    lib.mkIfFall cfg {
      home = {
        packages = with pkgs; [
          fd
          bat

          ripgrep
          repgrep

          eza
        ];

        file.".config/ripgrep".text = ''
          go.mod
          go.sum
          node_modules
        '';

        # Have to source it from a file because the prompt symbol padding
        # is not respected when set in hm module options
        sessionVariables.FZF_DEFAULT_OPTS_FILE = "$HOME/.config/fzf";
        file.".config/fzf".source = ./themes/fzf/${finalTheme};
      };

      programs.fzf = {
        enable = true;
      };
    })
  cfgs;
}
