{
  lib,
  pkgs,
  userCfg,
}:
let
  cfg = { };

  hypr_organize_workspaces = lib.writeScript {
    inherit pkgs cfg;
    name = "hypr_organize_workspaces";
    src = ./hypr_organize_workspaces.sh;
  };

  mpris_toggle_browser =
    let
      meta = lib.getMeta "browsers" userCfg.mainBrowser;
      cfg = {
        mpris-prefix = meta.mprisPrefix;
      };
    in
    lib.writeScript {
      inherit pkgs cfg;
      name = "mpris_toggle_browser";
      src = ./mpris_toggle_browser.sh;
    };

  pulsemixer_add = lib.writeScript {
    inherit pkgs cfg;
    name = "pulsemixer_add";
    src = ./pulsemixer_add.sh;
  };

  # Start process only if an identical one is not already running
  soft_start = lib.writeScript {
    inherit pkgs cfg;
    name = "soft_start";
    src = ./soft_start.sh;
  };

  # HACK: have to use it because of being unable to change qutebrowser wm class
  qutebrowser_in_current = lib.writeScript {
    inherit pkgs cfg;
    name = "qutebrowser_in_current";
    src = ./qutebrowser_in_current.sh;
  };

  smart_kill = lib.writeScript {
    inherit pkgs cfg;
    name = "smart_kill";
    src = ./smart_kill.sh;
  };

  to_prev_workspace = lib.writeScript {
    inherit pkgs cfg;
    name = "to_prev_workspace";
    src = ./to_prev_workspace.sh;
  };
in
{
  home.packages = [
    hypr_organize_workspaces
    mpris_toggle_browser
    pulsemixer_add
    soft_start
    qutebrowser_in_current
    smart_kill
    to_prev_workspace
  ];
}
