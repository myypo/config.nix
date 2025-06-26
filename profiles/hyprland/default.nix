{
  lib,
  inputs,
  pkgs,
  config,
  ...
}:
let
  userOpts = {
    options.profiles.hyprland = {
      enable = lib.mkEnableOption "hyprland profile";

      theme = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
      };

      monitors = lib.mkOption {
        type = lib.types.attrsOf (
          lib.types.submodule {
            options = {
              name = lib.mkOption { type = lib.types.str; };
              settings = lib.mkOption { type = lib.types.str; };
              position = lib.mkOption { type = lib.types.str; };
              scaling = lib.mkOption { type = lib.types.str; };
              extra = lib.mkOption {
                type = lib.types.nullOr lib.types.str;
                default = null;
              };
            };
          }
        );
      };

      addons = {
        clamshell = {
          enable = lib.mkEnableOption "clamshell";

          settings = {
            internalMonitorName = lib.mkOption { type = lib.types.str; };
            internalMonitorSettings = lib.mkOption { type = lib.types.str; };
            externalMonitorName = lib.mkOption { type = lib.types.str; };
          };
        };
        toggle_touchpad = {
          enable = lib.mkEnableOption "toggle touchpad";
          settings = {
            deviceName = lib.mkOption { type = lib.types.str; };
          };
        };
        swww = {
          enable = lib.mkEnableOption "swww";

          dynamic_wall = {
            enable = lib.mkEnableOption "dynamic wallpaper";
          };
        };
        swaylock = {
          enable = lib.mkEnableOption "swaylock";
        };
        waybar = {
          enable = lib.mkEnableOption "waybar";
          theme = lib.mkOption {
            type = lib.types.nullOr lib.types.str;
            default = null;
          };
        };
        to_notif = {
          enable = lib.mkEnableOption "to notification hyprland utility";
        };
        project_management = {
          enable = lib.mkEnableOption "hyprland project management";
        };
      };
    };
  };
in
{
  options = lib.makeHomeOpts userOpts;

  config = lib.makeHomeModule {
    inherit pkgs config;
    configPath = ./config.nix;
    type = "profiles";
    name = "hyprland";
    addArgsFn = userName: cfg: {
      inherit inputs;

      userCfg = config.myypo.users.${userName};

      cfg = cfg // {
        theme = lib.valueOrUserDefault {
          inherit config userName;
          name = "theme";
          val = cfg.theme;
        };

        addons = cfg.addons // {
          waybar = cfg.addons.waybar // {
            theme = lib.valueOrUserDefault {
              inherit config userName;
              name = "theme";
              val = cfg.addons.waybar.theme;
            };
          };
        };
      };
    };

    nixosConfig = {
      programs.hyprland = {
        enable = true;
        withUWSM = true;

        package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
        portalPackage =
          inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
      };
    };
  };
}
