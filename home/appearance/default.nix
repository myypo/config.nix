{lib, ...}:
with lib; let
  userOpts = {
    options.appearance.common = {
      enableAll = mkEnableOption "enable all appearance-related modules";
    };
  };

  dirModules = lib.readDirModules ./.;
in {
  options = lib.setSubOpts {inherit userOpts;};

  imports = dirModules;
}
