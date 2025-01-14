{
  lib,
  pkgs,
  theme,
  isMainMusicPlayer,
}:
lib.makeMusicPlayer isMainMusicPlayer "termusic.desktop" {
  home.packages = with pkgs; [
    termusic

    yt-dlp # Required to download stuff with termusic
  ];

  xdg = {
    configFile."termusic/config.toml".text = builtins.concatStringsSep "\n" [
      (builtins.readFile ./settings.toml)
      (builtins.readFile ./themes/${theme}/theme.toml)
    ];
  };
}
