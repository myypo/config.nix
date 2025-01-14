{
  lib,
  pkgs,
  userCfg,
  addons,
}:
let
  cfg = addons.project_management;

  project_search_float =
    let
      name = "project_search_float";
      src = ./project_search_float.sh;
    in
    lib.writeScript {
      inherit
        pkgs
        name
        cfg
        src
        ;
    };

  project_create_float =
    let
      name = "project_create_float";
      src = ./project_create_float.sh;
    in
    lib.writeScript {
      inherit
        pkgs
        name
        cfg
        src
        ;
    };

  compatible =
    let
      fishEnabled = lib.userCfgIsEnabled {
        inherit userCfg;
        type = "shells";
        name = "fish";
      };
      kittyEnabled = lib.userCfgIsEnabled {
        inherit userCfg;
        type = "terminals";
        name = "kitty";
      };
      nvimEnabled = lib.userCfgIsEnabled {
        inherit userCfg;
        type = "editors";
        name = "nvim";
      };

      ok = fishEnabled && kittyEnabled && nvimEnabled;
    in
    (lib.trivial.warnIfNot ok
      "Hyprland project management scripts are not compatible with the current configuration"
      ok
    );
in
lib.mkIf (cfg.enable && compatible) {
  home.packages = [
    project_search_float
    project_create_float
  ];
}
