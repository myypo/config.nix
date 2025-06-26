{ lib }:
rec {
  users = {
    myypo = {
      githubUserName = "myypo";

      theme = "mayu";
      fontSize = 16;

      mainShell = "fish";

      mainEditor = "nvim";
      mainBrowser = "qutebrowser";
      mainTerminal = "kitty";
      mainFileManager = "nemo";
      mainDocumentViewer = "zathura";
      mainImageViewer = "imv";
      mainVideoPlayer = "mpv";
      mainMusicPlayer = "termusic";

      appearance = {
        common = {
          enableAll = true;
        };

        cursor = {
          size = 48;
        };
      };

      dev-tools = {
        common = {
          enableAll = true;
        };
      };

      shells = {
        common = {
          enableAll = true;
        };
      };

      terminals = {
        kitty = {
          enable = true;
        };
      };

      editors = {
        nvim = {
          enable = true;
        };
      };

      browsers = {
        common = {
          enableAll = true;
        };
      };

      office = {
        common = {
          enableAll = true;
        };
      };

      recording = {
        common = {
          enableAll = true;
        };
      };

      widgets = {
        common = {
          enableAll = true;
        };
      };

      image = {
        common = {
          enableAll = true;
        };
      };

      music = {
        termusic.enable = true;
      };

      video = {
        common = {
          enableAll = true;
        };
      };

      file-managers = {
        nemo = {
          enable = true;
        };
      };

      other = {
        common = {
          enableAll = true;
        };

        wine.enable = false;
      };

      notifications = {
        common = {
          enable = true;
          backend = "mako";

          fontSize = 14;
        };
      };

      profiles = {
        hyprland = {
          enable = true;

          monitors = {
            external = {
              name = "DP-1";
              settings = "2560x1440@165";
              position = "0x0";
              scaling = "1";
            };
            internal = {
              name = "eDP-1";
              settings = "1920x1080@144";
              position = "0x0";
              scaling = "1.2";
              extra = "mirror,DP-1";
            };
          };

          addons = {
            clamshell = {
              enable = true;
              settings = {
                internalMonitorName = "eDP-1";
                internalMonitorSettings = "1920x1080@144";
                externalMonitorName = "DP-1";
              };
            };

            toggle_touchpad = {
              enable = true;
              settings = {
                deviceName = "elan1205:00-04f3:30e9-touchpad";
              };
            };

            swww = {
              enable = true;
              dynamic_wall = {
                enable = true;
              };
            };

            swaylock = {
              enable = true;
            };
            waybar = {
              enable = true;
            };
            to_notif = {
              enable = true;
            };
            project_management = {
              enable = true;
            };
          };
        };
      };
    };
  };

  hardware = {
    bluetooth = {
      enable = true;
    };
    ssd = {
      enable = true;
    };

    cpu = {
      enable = true;
      brand = "intel";
    };

    gpu = {
      enable = true;

      dedicatedBrand = null;
      integratedBrand = "intel";

      integratedBusId = "PCI:00:02:0";
      dedicatedBusId = null;

      integratedDriNum = 1;
      dedicatedDriNum = null;

      optimus = {
        enable = false;
      };
    };
  };

  home-manager = {
    enable = true;
  };
  laptop-services = {
    enable = true;
    disableNvidia = true;
  };
  ukr-locale = {
    enable = true;
  };
  fonts = {
    enable = true;
  };

  security = {
    privilege-elevation = {
      cmd = "doas";
    };
  };

  nixos = {
    substituters = {
      enable = true;
    };
  };

  programs = {
    docker = {
      enable = true;
      members = lib.attrsets.mapAttrsToList (userName: _: userName) users;
    };
    term-utils = {
      enable = true;
    };
    archiving = {
      enable = true;
    };
  };

  services = {
    custom = {
      nordvpn = {
        enable = false;
      };

      battery-charge-threshold = {
        enable = true;
        batteryName = "BAT0";
        maxChargeLevel = 80;
      };

      min-brightness = {
        enable = true;
        minLevel = 1;
      };

      polkit-gnome = {
        enable = true;
      };
    };

    builtin = {
      autologin = {
        enable = true;
        userName = "myypo";
      };

      dbus = {
        enable = true;
      };

      dual-function-keys = {
        enable = true;
      };

      openssh = {
        enable = true;
      };

      pipewire = {
        enable = true;
      };
    };
  };
}
