{
  lib,
  pkgs,
  ...
}: {
  imports = lib.readFileModules ./.;

  config = {
    boot = {
      kernelPackages = pkgs.linuxPackages_xanmod_latest;
    };
  };
}
