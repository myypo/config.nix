{ fontSize }:
{
  services.mako = {
    settings = {
      font = "JetBrainsMono Nerd Font ${builtins.toString fontSize}";

      default-timeout = "5000";

      text-alignment = "center";

      width = "350";
      height = "500";

      margin = "15";
      padding = "15,10";

      border-size = "3";
      border-radius = "3";
      border-color = "#eba4ac";

      background-color = "#000000";
      progress-color = "over #DEDDDD";
      text-color = "#DEDDDD";

      "urgency=high" = {
        border-color = "#eb6f92";
      };
      "app-name=NetworkManager\\ Applet" = {
        invisible = "1";
      };
    };
  };
}
