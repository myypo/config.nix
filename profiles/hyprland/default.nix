{
  lib,
  inputs,
  pkgs,
  config,
  ...
}:
with lib; let
  cfgs = lib.getCfgs {
    inherit config;
    type = "profiles";
    name = "hyprland";
  };
  enable = lib.cfgIsEnabled {
    inherit config;
    type = "profiles";
    name = "hyprland";
  };

  userOpts = {
    options.profiles.hyprland = {
      enable = mkEnableOption "hyprland profile";

      theme = mkOption {
        type = types.nullOr types.str;
        default = null;
      };

      monitors = mkOption {
        type = types.attrsOf (types.submodule {
          options = {
            name = mkOption {type = types.str;};
            settings = mkOption {type = types.str;};
            position = mkOption {type = types.str;};
            scaling = mkOption {type = types.str;};
            extra = mkOption {
              type = types.nullOr types.str;
              default = null;
            };
          };
        });
      };

      addons = {
        clamshell = {
          enable = mkEnableOption "clamshell";

          settings = {
            internalMonitorName = mkOption {type = types.str;};
            internalMonitorSettings = mkOption {type = types.str;};
            externalMonitorName = mkOption {type = types.str;};
          };
        };
        toggle_touchpad = {
          enable = mkEnableOption "toggle touchpad";
          settings = {
            deviceName = mkOption {
              type = types.str;
            };
          };
        };
        swww = {
          enable = mkEnableOption "swww";

          dynamic_wall = {
            enable = mkEnableOption "dynamic wallpaper";
          };
        };
        swaylock = {
          enable = mkEnableOption "swaylock";
        };
        waybar = {
          enable = mkEnableOption "waybar";
          theme = mkOption {
            type = types.nullOr types.str;
            default = null;
          };
        };
        to_notif = {
          enable = mkEnableOption "to notification hyprland utility";
        };
        project_management = {
          enable = mkEnableOption "hyprland project management";
        };
      };
    };
  };
in {
  options = lib.setSubOpts {inherit userOpts;};

  config = mkIf enable {
    home-manager.users =
      builtins.mapAttrs (
        userName: cfg:
          mkIf cfg.enable (import ./config.nix {
            inherit lib inputs pkgs;

            userCfg = config.myypo.users.${userName};

            cfg =
              cfg
              // {
                theme = lib.valueOrUserDefault {
                  inherit config userName;
                  name = "theme";
                  val = cfg.theme;
                };

                addons =
                  cfg.addons
                  // {
                    waybar =
                      cfg.addons.waybar
                      // {
                        theme = lib.valueOrUserDefault {
                          inherit config userName;
                          name = "theme";
                          val = cfg.addons.waybar.theme;
                        };
                      };
                  };
              };
          })
      )
      cfgs;

    programs = {
      # Have to be enabled to use apps that do not support wayland
      xwayland.enable = false;

      dconf.enable = true;
    };

    xdg.portal = with pkgs; {
      enable = true;
      extraPortals = [xdg-desktop-portal-gtk xdg-desktop-portal-hyprland];
      configPackages = [hyprland];
    };

    environment.systemPackages = with pkgs; [
      wl-clipboard
      wlr-randr
      wayland
      wayland-scanner
      wayland-utils
      egl-wayland
      wayland-protocols
      glfw-wayland
      qt6.qtwayland
      wev
    ];
  };
}
