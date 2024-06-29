{lib, ...}:
with lib; let
  userOpts = {
    options.recording.common = {
      enableAll = mkEnableOption "enable all configured programs for video recording and screenshots";
    };
  };

  dirModules = lib.readDirModules ./.;
in {
  options = lib.setSubOpts {inherit userOpts;};

  imports = dirModules;
}
