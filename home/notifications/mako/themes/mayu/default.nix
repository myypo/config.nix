{fontSize}: {
  services.mako = {
    font = "JetBrainsMono Nerd Font ${builtins.toString fontSize}";

    width = 350;
    height = 500;

    margin = "15";
    padding = "15,10";

    borderSize = 3;
    borderRadius = 3;
    borderColor = "#eba4ac";

    backgroundColor = "#000000";
    progressColor = "over #DEDDDD";
    textColor = "#DEDDDD";

    extraConfig = ''
      default-timeout=5000

      text-alignment=center

      [urgency=high]
      border-color=#eb6f92

      [app-name="NetworkManager Applet"]
      invisible=1
    '';
  };
}
