{ lib, isMainDocumentViewer, ... }:
let
  xdgPdfReader = [
    "zathura.desktop"
    "org.pwmt.zathura.desktop"
  ];
  associations = {
    "application/pdf" = xdgPdfReader;
    "application/x-pdf" = xdgPdfReader;
  };
in
{
  xdg = lib.mkIf isMainDocumentViewer {
    mimeApps = {
      defaultApplications = associations;
      associations.added = associations;
    };
  };

  programs.zathura = {
    enable = true;
    options = {
      # Open document in fit-width mode by default
      adjust-open = "best-fit";

      # One page per row by default
      pages-per-row = 1;

      scroll-page-aware = "true";
      scroll-full-overlap = "0.01";

      zoom-min = 10;
      guioptions = "";

      font = "DaddyTimeMono Nerd Font 15";
      default-fg = "#96CDFB";
      default-bg = "#1A1823";

      completion-bg = "#1A1823";
      completion-fg = "#96cdfb";
      completion-highlight-bg = "#302D41";
      completion-highlight-fg = "#96cdfb";
      completion-group-bg = "#1a1823";
      completion-group-fg = "#89DCEB";

      statusbar-fg = "#C9CBFF";
      statusbar-bg = "#1A1823";
      statusbar-h-padding = 10;
      statusbar-v-padding = 10;

      notification-bg = "#1A1823";
      notification-fg = "#D9E0EE";
      notification-error-bg = "#d9e0ee";
      notification-error-fg = "#D9E0EE";
      notification-warning-bg = "#FAE3B0";
      notification-warning-fg = "#D9E0EE";
      selection-notification = "true";

      inputbar-fg = "#C9CBFF";
      inputbar-bg = "#1A1823";

      index-fg = "#96cdfb";
      index-bg = "#1A1823";
      index-active-fg = "#96cdfb";
      index-active-bg = "#1A1823";

      render-loading-bg = "#1A1823";
      render-loading-fg = "#96cdfb";

      highlight-color = "#96cdfb";
      highlight-active-color = "#DDB6F2";

      render-loading = "false";
      scroll-step = 100;

      selection-clipboard = "clipboard";
    };
  };
}
