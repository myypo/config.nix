{lib, ...}:
with lib; let
  userOpts = {
    options.widgets.common = {
      enableAll = mkEnableOption "enable all configured widget apps";
    };
  };

  dirModules = lib.readDirModules ./.;
in {
  options = lib.setSubOpts {inherit userOpts;};

  imports = dirModules;
}