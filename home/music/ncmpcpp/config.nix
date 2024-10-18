{
  lib,
  pkgs,
  isMainMusicPlayer,
}:
lib.mkMusicPlayer isMainMusicPlayer "ncmpcpp.desktop" {
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
}
