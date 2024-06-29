{lib, ...}:
with lib; let
  userOpts = {
    options.browsers.common = {
      enableAll = mkEnableOption "enable all configured web-browsers";
    };
  };

  dirModules = lib.readDirModules ./.;
in {
  options = lib.setSubOpts {inherit userOpts;};

  imports = dirModules;
}
