{
  lib,
  pkgs,
  theme,
  isMainMusicPlayer,
}: let
  xdgMusicPlayer = "termusic.desktop";
in {
  home.packages = with pkgs; [
    termusic

    yt-dlp # Required to download stuff with termusic
  ];

  home.file.".config/termusic/config.toml".text =
    builtins.concatStringsSep "\n"
    [(builtins.readFile ./settings.toml) (builtins.readFile ./themes/${theme}/theme.toml)];

  xdg = lib.mkIf isMainMusicPlayer (lib.setMainMusicPlayer {inherit xdgMusicPlayer;});
}
