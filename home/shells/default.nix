{lib, ...}:
with lib; let
  userOpts = {
    options.shells.common = {
      enableAll = mkEnableOption "enable all configured shells";
    };
  };

  dirModules = lib.readDirModules ./.;
in {
  options = lib.setSubOpts {inherit userOpts;};

  imports = dirModules;
}
