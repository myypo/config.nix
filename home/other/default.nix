{lib, ...}:
with lib; let
  userOpts = {
    options.other.common = {
      enableAll = mkEnableOption "enable all not assorted modules";
    };
  };

  dirModules = lib.readDirModules ./.;
in {
  options = lib.setSubOpts {inherit userOpts;};

  imports = dirModules;
}
