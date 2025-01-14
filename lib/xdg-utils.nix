{ lib }:
let
  makeMainXdg =
    isMain: xdgName: fileTypes: rest:
    let
      associations = lib.trivial.pipe fileTypes [
        (builtins.map (ft: {
          name = ft;
          value = [ xdgName ];
        }))
        (builtins.listToAttrs)
      ];
    in
    lib.attrsets.recursiveUpdate {
      xdg.mimeApps = lib.mkIf isMain {
        defaultApplications = associations;
        associations.added = associations;
      };
    } rest;
in
{
  makeBrowser =
    isMain: xdgBrowser: rest:
    let
      fileTypes = [
        "text/html"
        "x-scheme-handler/http"
        "x-scheme-handler/https"
        "x-scheme-handler/ftp"
        "x-scheme-handler/chrome"
        "x-scheme-handler/about"
        "x-scheme-handler/unknown"
        "application/x-extension-htm"
        "application/x-extension-html"
        "application/x-extension-shtml"
        "application/xhtml+xml"
        "application/x-extension-xhtml"
        "application/x-extension-xht"
      ];
    in
    makeMainXdg isMain xdgBrowser fileTypes rest;

  makeImageViewer =
    isMain: xdgImageViewer: rest:
    let
      fileTypes = [
        "image/png"
        "image/jpg"
        "image/jpeg"
        "image/gif"
        "image/bmp"
        "image/svg"
        "image/tiff"
        "image/webp"
      ];
    in
    makeMainXdg isMain xdgImageViewer fileTypes rest;

  makeVideoPlayer =
    isMain: xdgVideoPlayer: rest:
    let
      fileTypes = [
        "video/mp4"
        "video/webm"
        "video/mpeg"
        "video/quicktime"
      ];
    in
    makeMainXdg isMain xdgVideoPlayer fileTypes rest;

  makeMusicPlayer =
    isMain: xdgMusicPlayer: rest:
    let
      fileTypes = [
        "audio/mp3"
        "audio/ogg"
        "audio/wav"
        "audio/flac"
      ];
    in
    makeMainXdg isMain xdgMusicPlayer fileTypes rest;
}
