{}: {
  setMainBrowser = {xdgBrowser}: let
    browserList = [xdgBrowser];
    associations = {
      "text/html" = browserList;
      "x-scheme-handler/http" = browserList;
      "x-scheme-handler/https" = browserList;
      "x-scheme-handler/ftp" = browserList;
      "x-scheme-handler/chrome" = browserList;
      "x-scheme-handler/about" = browserList;
      "x-scheme-handler/unknown" = browserList;
      "application/x-extension-htm" = browserList;
      "application/x-extension-html" = browserList;
      "application/x-extension-shtml" = browserList;
      "application/xhtml+xml" = browserList;
      "application/x-extension-xhtml" = browserList;
      "application/x-extension-xht" = browserList;
    };
  in {
    mimeApps = {
      defaultApplications = associations;
      associations.added = associations;
    };
  };

  setMainImageViewer = {xdgImageViewer}: let
    imageViewerList = [xdgImageViewer];
    associations = {
      "image/png" = imageViewerList;
      "image/jpg" = imageViewerList;
      "image/jpeg" = imageViewerList;
      "image/gif" = imageViewerList;
      "image/bmp" = imageViewerList;
      "image/svg" = imageViewerList;
      "image/tiff" = imageViewerList;
      "image/webp" = imageViewerList;
    };
  in {
    mimeApps = {
      defaultApplications = associations;
      associations.added = associations;
    };
  };

  setMainVideoPlayer = {xdgVideoPlayer}: let
    videoPlayerList = [xdgVideoPlayer];
    associations = {
      "video/mp4" = videoPlayerList;
      "video/webm" = videoPlayerList;
      "video/mpeg" = videoPlayerList;
      "video/quicktime" = videoPlayerList;
    };
  in {
    mimeApps = {
      defaultApplications = associations;
      associations.added = associations;
    };
  };

  setMainMusicPlayer = {xdgMusicPlayer}: let
    musicPlayerList = [xdgMusicPlayer];
    associations = {
      "audio/mp3" = musicPlayerList;
      "audio/ogg" = musicPlayerList;
      "audio/wav" = musicPlayerList;
      "audio/flac" = musicPlayerList;
    };
  in {
    mimeApps = {
      defaultApplications = associations;
      associations.added = associations;
    };
  };
}
