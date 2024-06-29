{lib, ...}:
with lib; let
  userOpts = {
    options.file-managers.common = {
      enableAll = mkEnableOption "enable all 'file-managers' modules";
    };
  };

  dirModules = lib.readDirModules ./.;
in {
  options = lib.setSubOpts {inherit userOpts;};

  imports = dirModules;
}
