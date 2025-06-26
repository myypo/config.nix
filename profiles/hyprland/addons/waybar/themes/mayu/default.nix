{ pkgs }:
{
  home.packages = with pkgs; [ wttrbar ];

  # Applet is used in the waybar "tray" module
  services.network-manager-applet.enable = true;

  programs.waybar = {
    enable = true;
    style = ./mayu-waybar.css;
    settings = [
      {
        "layer" = "top";
        "position" = "top";
        modules-left = [
          "temperature"
          "custom/weather"
          "clock"
        ];
        modules-center = [ "hyprland/workspaces" ];
        modules-right = [
          "pulseaudio"
          "memory"
          "cpu"
          "battery"
          "tray"
        ];
        "custom/weather" = {
          "format" = "{}°C";
          "tooltip" = true;
          "interval" = 3600;
          "exec" =
            "sleep 15 && wttrbar --date-format '%m/%d' --location Kamianets-Podilskyi --ampm --hide-conditions &";
          "return-type" = "json";
        };
        "hyprland/workspaces" = {
          "all-outputs" = false;
          "disable-scroll" = true;
          "on-click" = "activate";
        };
        "backlight" = {
          "device" = "intel_backlight";
          "on-scroll-up" = "light -A 1";
          "on-scroll-down" = "light -U 1";
          "format" = "<span color=\"#f6c177\">{icon} </span>{percent}%";
          "format-icons" = [
            "󰃝"
            "󰃞"
            "󰃟"
            "󰃠"
          ];
          "tooltip" = false;
        };
        "pulseaudio" = {
          "scroll-step" = 10;
          "format" = "<span color=\"#f6c177\">{icon} </span>{volume}%";
          "format-muted" = "<span color=\"#f6c177\">󰖁 Muted</span>";
          "format-icons" = {
            "default" = [
              "󰕿"
              "󰖀"
              "󰕾 "
            ];
          };
          "on-click" = "pulsemixer --toggle-mute";
          "tooltip" = false;
        };
        "battery" = {
          "interval" = 60;
          "states" = {
            "warning" = 20;
            "critical" = 10;
          };
          "format" = "<span color=\"#f6c177\">{icon} </span>{capacity}%";
          "format-icons" = [
            "󰁺"
            "󰁻"
            "󰁼"
            "󰁽"
            "󰁾"
            "󰁿"
            "󰂀"
            "󰂁"
            "󰂂"
            "󰁹"
          ];
          "format-full" = "<span color=\"#f6c177\">{icon} </span>{capacity}%";
          "format-charging" = "<span color=\"#f6c177\">󰂄 </span>{capacity}%";
          "tooltip" = false;
        };
        "clock" = {
          "interval" = 1;
          "format" = "<span color=\"#f6c177\">⌛</span> {:%a, %b %d | %I:%M %p}";
          "tooltip" = true;
          "tooltip-format" = "<tt><small>{calendar}</small></tt>";
          "calendar" = {
            "mode" = "year";
            "mode-mon-col" = 3;
            "weeks-pos" = "right";
            "on-scroll" = 1;
            "on-click-right" = "mode";
            "format" = {
              "months" = "<span color='#DEDDDD'><b>{}</b></span>";
              "days" = "<span color='#eba4ac'><b>{}</b></span>";
              "weeks" = "<span color='#9ccfd8'><b>W{}</b></span>";
              "weekdays" = "<span color='#f6c177'><b>{}</b></span>";
              "today" = "<span color='#eb6f92'><b><u>{}</u></b></span>";
            };
          };
          "actions" = {
            "on-click-right" = "mode";
            "on-scroll-up" = "shift_up";
            "on-scroll-down" = "shift_down";
          };
        };
        "memory" = {
          "interval" = 1;
          "format" = "<span color=\"#f6c177\">󰍛 </span>{percentage}%";
          "states" = {
            "warning" = 85;
          };
        };
        "cpu" = {
          "interval" = 1;
          "format" = "<span color=\"#f6c177\">󰻠 </span>{usage}%";
        };
        "temperature" = {
          # TODO: fix for the laptop
          # "thermal-zone" = 7;
          "hwmon-path" = "/sys/class/hwmon/hwmon1/temp1_input";
          "interval" = 1;
          "tooltip" = false;
          "format" = "<span color=\"#f6c177\"> </span>{temperatureC}°C";
        };
        "tray" = {
          "icon-size" = 15;
          "spacing" = 5;
        };
      }
    ];
  };
}
