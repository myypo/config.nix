{
  lib,
  pkgs,
  isMainMusicPlayer,
}: let
  xdgMusicPlayer = "ncmpcpp.desktop";
in {
  programs.ncmpcpp = {
    enable = true;

    bindings = [
      {
        key = "d";
        command = "delete_playlist_items";
      }
      {
        key = "d";
        command = "delete_browser_items";
      }
      {
        key = "d";
        command = "delete_stored_playlist";
      }
    ];
  };

  home.packages = with pkgs; [
    mpc-cli
  ];

  xdg = lib.mkIf isMainMusicPlayer (lib.setMainMusicPlayer {inherit xdgMusicPlayer;});
}
