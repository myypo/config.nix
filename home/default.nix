{
  lib,
  inputs,
  config,
  myypo,
  ...
}:
with lib;
let
  usersCfg = config.myypo.users;
  hmCfg = config.myypo.home-manager;

  hmUserDefinitions = { inherit myypo; };

  dirModules = lib.readDirModules ./.;
in
{
  imports = dirModules ++ [
    # Have to do it to pass user-specific home configs
    hmUserDefinitions

    inputs.home-manager.nixosModules.default
  ];

  options.myypo.home-manager = {
    enable = mkEnableOption "whether to enable home-manager on the machine";
  };

  config = mkIf hmCfg.enable {
    home-manager = {
      # Create backup files instead of exiting with an error on hm collision
      backupFileExtension = "hm_backup_";

      useGlobalPkgs = true;
      useUserPackages = true;
      verbose = true;
      sharedModules = [ { home.stateVersion = mkForce config.system.stateVersion; } ];
    };
    home-manager.users = builtins.mapAttrs (userName: _: {
      programs.home-manager.enable = true;
      home = {
        username = userName;
        homeDirectory = "/home/${userName}";
      };
    }) usersCfg;
  };
}
