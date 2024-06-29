{lib, ...}:
with lib; let
  userOpts = {
    options.terminals.common = {
      enableAll = mkEnableOption "enable all configured terminal emulators";
    };
  };

  dirModules = lib.readDirModules ./.;
in {
  options = lib.setSubOpts {inherit userOpts;};

  imports = dirModules;
}
