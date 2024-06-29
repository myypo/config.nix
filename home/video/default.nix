{lib, ...}:
with lib; let
  userOpts = {
    options.video.common = {
      enableAll = mkEnableOption "enable all video players and editors";
    };
  };

  dirModules = lib.readDirModules ./.;
in {
  options = lib.setSubOpts {inherit userOpts;};

  imports = dirModules;
}