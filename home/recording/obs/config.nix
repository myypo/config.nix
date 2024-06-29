{}: {
  programs = {
    obs-studio.enable = true;
  };
  home.file.".config/obs-studio/themes".source = ./themes;
  home.file.".config/obs-studio/global.ini".source = ./global.ini;
}
