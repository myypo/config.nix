{lib, ...}:
with lib; let
  userOpts = {
    options.editors.common = {
      enableAll = mkEnableOption "enable all configured code editors";
    };
  };

  dirModules = lib.readDirModules ./.;
in {
  options = lib.setSubOpts {inherit userOpts;};

  imports = dirModules;
}
